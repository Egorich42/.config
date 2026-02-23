" =============================================================================
" CLEAN GO + AI CONFIG (CLOJURE REMOVED)
" =============================================================================

let mapleader = " " " Лидер — ПРОБЕЛ
syntax on
set number
set noswapfile
set clipboard+=unnamedplus
color industry

call plug#begin('~/.vim/plugged')

" --- UI & Editor ---
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-repeat'
Plug 'luochen1990/rainbow'
Plug 'vim-airline/vim-airline'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'scrooloose/nerdtree'

" --- Languages & Tools (Go Only) ---
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tpope/vim-commentary' 
Plug 'tpope/vim-surround' 
Plug 'jgdavey/tslime.vim'
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'tyru/open-browser.vim'
Plug 'aklt/plantuml-syntax'

" --- AI & Context Section ---
Plug 'github/copilot.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'main' }
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'akinsho/toggleterm.nvim'

call plug#end()

" --- Настройки плагинов (VimScript) ---
let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1

" --- Lua Блок ---
lua << EOF
local chat = require("CopilotChat")

-- 1. Базовый Setup CopilotChat
chat.setup({
    debug = false,
    language = "Russian",
    contexts = {
        buffer = { enabled = true },
        buffers = { enabled = true },
    },
    system_prompt = "You are a Go expert. STRIKT RULES: No comments in code. English comments ONLY if critical. Idiomatic Go.",
})

-- 2. КОМАНДА-СПАСИТЕЛЬ: :Force <вопрос>
-- Принудительно собирает текст всех открытых файлов в один запрос
vim.api.nvim_create_user_command("Force", function(opts)
    local context = "ИСПОЛЬЗУЙ ЭТОТ КОД КАК КОНТЕКСТ:\n\n"
    local found_any = false
    
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_get_option_value("buflisted", { buf = bufnr }) then
            local name = vim.api.nvim_buf_get_name(bufnr)
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
            if #lines > 0 then
                context = context .. "--- FILE: " .. name .. " ---\n"
                context = context .. table.concat(lines, "\n") .. "\n\n"
                found_any = true
            end
        end
    end
    
    if not found_any then
        print("Ошибка: Нет открытых буферов для анализа!")
        return
    end
    
    chat.ask(context .. "\nЗАДАЧА: " .. opts.args)
end, { nargs = "*" })

-- Команда :CSend
-- Просто открываешь файл и пишешь :CSend. Файл улетает в историю чата.
vim.api.nvim_create_user_command("CSend", function()
    local chat = require("CopilotChat")
    local filename = vim.fn.expand("%:p:t") -- Get current file name
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local content = table.concat(lines, "\n")
    
    local prompt = "Вот содержимое файла " .. filename .. ". Просто запомни его для контекста, отвечать не нужно.\n\n```" .. vim.bo.filetype .. "\n" .. content .. "\n```"
    
    -- Отправляем в чат
    chat.ask(prompt)
    print("Файл " .. filename .. " отправлен в контекст чата.")
end, {})

-- Быстрая клавиша для отправки текущего файла: Space + c + s
vim.keymap.set('n', '<leader>cs', ':CSend<CR>', { silent = true })

-- 3. Снайперская вставка кода (gp)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "copilot-chat",
    callback = function()
        vim.keymap.set("n", "gp", function()
            local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
            local block = {}
            local in_block = false
            for i = 1, #lines do
                if lines[i]:match("^```") then
                    if not in_block then 
                        block = {} 
                        in_block = true 
                    else 
                        in_block = false 
                    end
                elseif in_block then 
                    table.insert(block, lines[i]) 
                end
            end
            
            if #block > 0 then
                vim.cmd("wincmd p")
                local row = vim.api.nvim_win_get_cursor(0)[1]
                vim.api.nvim_buf_set_lines(0, row, row, false, block)
                if vim.bo.filetype == "go" then 
                    vim.cmd("silent! GoFmt") 
                end
                vim.cmd("wincmd p")
            else
                print("Код не найден в чате!")
            end
        end, { buffer = true, desc = "Precise paste" })
    end,
})

-- 4. Горячие клавиши (Space + клавиша)
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { silent = true })
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', { silent = true })
vim.keymap.set('n', '<leader>cc', ':CopilotChatToggle<CR>', { silent = true })

-- 5. Прочие настройки
require("toggleterm").setup{ direction = 'float' }
-- 5. Настройка терминала (Space + t)
local toggleterm = require("toggleterm")
if toggleterm then
    toggleterm.setup({
        -- Убираем старый маппинг, он на Mac глючит
        open_mapping = nil, 
        direction = 'float',
        float_opts = { border = 'curved' },
    })
    
    -- Назначаем Space + t для открытия/закрытия
    vim.keymap.set('n', '<leader>t', ':ToggleTerm<CR>', { silent = true })
end

-- Удобный выход из режима терминала через Esc Esc
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc><esc>', [[<C-\><C-n>]], opts)
end
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
EOF
