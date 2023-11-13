-- Set colorscheme --
vim.o.termguicolors = true
vim.cmd [[colorscheme catppuccin]]

-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = '|',
    section_separators = { left = '' , right = '' },
  },
}

-- ChatGPT.nvim --
require("chatgpt").setup({
  api_key_cmd = nil,
  yank_register = "+",
  edit_with_instructions = {
    diff = false,
    keymaps = {
      close = "<C-c>",
      accept = "<C-y>",
      toggle_diff = "<C-d>",
      toggle_settings = "<C-o>",
      cycle_windows = "<Tab>",
      use_output_as_input = "<C-i>",
    },
  },
  chat = {
    welcome_message = WELCOME_MESSAGE,
    loading_text = "Loading, please wait ...",
    question_sign = "", -- 🙂 
    answer_sign = "ﮧ", -- 🤖 
    max_line_length = 120,
    sessions_window = {
      border = {
        style = "rounded",
        text = {
          top = " Sessions ",
        },
      },
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      },
    },
    keymaps = {
      close = { "<C-c>" },
      yank_last = "<C-y>",
      yank_last_code = "<C-k>",
      scroll_up = "<C-u>",
      scroll_down = "<C-d>",
      new_session = "<C-n>",
      cycle_windows = "<Tab>",
      cycle_modes = "<C-f>",
      next_message = "<C-j>",
      prev_message = "<C-k>",
      select_session = "<Space>",
      rename_session = "r",
      delete_session = "d",
      draft_message = "<C-d>",
      edit_message = "e",
      delete_message = "d",
      toggle_settings = "<C-o>",
      toggle_message_role = "<C-r>",
      toggle_system_role_open = "<C-s>",
      stop_generating = "<C-x>",
    },
  },
  popup_layout = {
    default = "center",
    center = {
      width = "80%",
      height = "80%",
    },
    right = {
      width = "30%",
      width_settings_open = "50%",
    },
  },
  popup_window = {
    border = {
      highlight = "FloatBorder",
      style = "rounded",
      text = {
        top = " ChatGPT ",
      },
    },
    win_options = {
      wrap = true,
      linebreak = true,
      foldcolumn = "1",
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    },
    buf_options = {
      filetype = "markdown",
    },
  },
  system_window = {
    border = {
      highlight = "FloatBorder",
      style = "rounded",
      text = {
        top = " SYSTEM ",
      },
    },
    win_options = {
      wrap = true,
      linebreak = true,
      foldcolumn = "2",
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    },
  },
  popup_input = {
    prompt = "  ",
    border = {
      highlight = "FloatBorder",
      style = "rounded",
      text = {
        top_align = "center",
        top = " Prompt ",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    },
    submit = "<C-Enter>",
    submit_n = "<Enter>",
    max_visible_lines = 20,
  },
  settings_window = {
    border = {
      style = "rounded",
      text = {
        top = " Settings ",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    },
  },
  openai_params = {
    model = "gpt-3.5-turbo",
    frequency_penalty = 0,
    presence_penalty = 0,
    max_tokens = 300,
    temperature = 0,
    top_p = 1,
    n = 1,
  },
  openai_edit_params = {
    model = "gpt-3.5-turbo",
    frequency_penalty = 0,
    presence_penalty = 0,
    temperature = 0,
    top_p = 1,
    n = 1,
  },
  use_openai_functions_for_edits = false,
  actions_paths = {},
  show_quickfixes_cmd = "Trouble quickfix",
  predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
})

-- mini.animate --
require('mini.animate').setup()

-- Remaps --
vim.keymap.set("n", "<leader>n", vim.cmd.Ex, { desc = '[n]etrw' })
vim.keymap.set('n', '<leader>fi', require('telescope.builtin').git_files, { desc = '[F]ind Files in Git' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]ind by [G]rep' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind current [W]ord' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').resume, { desc = '[F]ind [R]esume' })

-- Do not yank with x
vim.keymap.set("n", "x", '"_x')

-- Select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")

-- Move whole blocks of code in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Eyes on the prize guys
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Don't Yank what you just Yeeted
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank in the System Clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Editor Settings --
-- Love Relative Line Numbers
vim.opt.relativenumber = true

-- 4 Space Indents
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Helps with Search Highlighting
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Less Disorienting Scroll
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Love Fast Update time
vim.opt.updatetime = 50

-- I don't wanna go beyond 80
vim.opt.colorcolumn = "80"
