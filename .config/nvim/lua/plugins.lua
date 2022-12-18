local utils = require('utils')

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  use 'ryanoasis/vim-devicons'

  use 'andymass/vim-matchup'

  use 'kevinhwang91/nvim-bqf'

  use 'lukas-reineke/indent-blankline.nvim'

  use {
    'neoclide/coc.nvim',
    branch = 'release'
  }

  use 'airblade/vim-rooter'

  use 'romainl/vim-qf'

  use 'flazz/vim-colorschemes'

  use 'tpope/vim-fugitive'

  use 'lewis6991/gitsigns.nvim'

  use 'junegunn/gv.vim'

  use 'tpope/vim-rhubarb'

  use 'jiangmiao/auto-pairs'

  use 'rhysd/conflict-marker.vim'

  use 'powerline/fonts'

  use {'junegunn/fzf', run = function()
    vim.fn['fzf#install']()
  end
  }

  use {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  use 'tpope/vim-commentary'

  use {
    'preservim/nerdtree',
    cmd = {'NERDTreeToggle', 'NERDTreeFind'}
  }

  use 'Xuyuanp/nerdtree-git-plugin'

  use 'mbbill/undotree'

  use 'godlygeek/tabular'

  use 'wellle/targets.vim'

  use 'tpope/vim-surround'

  use 'tpope/vim-repeat'

  use 'preservim/tagbar'

  use 'christoomey/vim-sort-motion'

  use 'gko/vim-coloresque'

  use 'michaeljsmith/vim-indent-object'

  use 'kana/vim-textobj-user'

  use 'preservim/vim-textobj-sentence'

  use 'powerman/vim-plugin-AnsiEsc'

  use 'lewis6991/impatient.nvim'

  use 'preservim/vimux'

  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
      require'alpha'.setup(require'alpha.themes.startify'.config)
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  --- ********************************************
  --- ************ Plugin Setups ****************
  --- ********************************************
  --- fzf-lua
  require'fzf-lua'.setup {
    winopts = {
      height = 0.9,
      width = 0.9,
    },
    previewers = {
      git_diff = {
        pager = "delta --width=$FZF_PREVIEW_COLUMNS",
      },
    },
    keymap = {
      fzf = {
        ["ctrl-z"] = "abort",
        ["ctrl-k"] = "unix-line-discard",
        ["ctrl-d"] = "preview-page-down",
        ["ctrl-u"] = "preview-page-up",
      }
    },
    git = {
      commits = {
        preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
      },
      bcommits = {
        preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
      },
    }
  }
  --- lualine
  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'gruvbox_dark',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {'quickfix', 'nerdtree', 'fugitive'}
  }
  
  --- nvim-treesitter
  require('nvim-treesitter.configs').setup {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = { 'go', 'lua', 'python', 'rust', 'typescript', 'help' },

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<c-backspace>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = { --ignore-scripts
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }

  --- indent_blankline
  require('indent_blankline').setup()

  --- gitsigns
  require('gitsigns').setup {
    signs = {
      add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
      change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      interval = 1000,
      follow_files = true
    },
    attach_to_untracked = true,
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
      -- Options passed to nvim_open_win
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1
    },
    yadm = {
      enable = false
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      -- Actions
      map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
      map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
      map('n', '<leader>hS', gs.stage_buffer)
      map('n', '<leader>hu', gs.undo_stage_hunk)
      map('n', '<leader>hR', gs.reset_buffer)
      map('n', '<leader>hp', gs.preview_hunk)

      -- Text object
      map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
  }

  --- ********************************************
  --- ************ Plugin Configs ****************
  --- ********************************************
  --- Nerdtree
  utils.nmap('<C-e>', ':NERDTreeToggle<CR>')
  utils.nmap('<leader>nf', ':NERDTreeFind<CR>')
  vim.g.nerdtree_tabs_open_on_gui_startup = 0
  vim.cmd([[
    let NERDTreeShowBookmarks=1
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeMouseMode=2
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
  ]])

  --- Coc
  vim.o.backup = false
  vim.o.writebackup = false
  vim.o.updatetime = 300
  vim.o.signcolumn = "yes"
  vim.g.coc_global_extensions = {
    'coc-clangd',
    'coc-css',
    'coc-diagnostic',
    'coc-eslint',
    'coc-git',
    'coc-go',
    'coc-html',
    'coc-json',
    'coc-markdownlint',
    'coc-phpls',
    'coc-prettier',
    'coc-pyright',
    'coc-rust-analyzer',
    'coc-sh',
    'coc-solargraph',
    'coc-sumneko-lua',
    'coc-tsserver'
  }
  utils.nmap('<C-j>', '<Plug>(coc-diagnostic-next)')
  utils.nmap('<C-k>', '<Plug>(coc-diagnostic-prev)')
  utils.nmap('gd', '<Plug>(coc-definition)')
  utils.nmap('gy', '<Plug>(coc-type-definition)')
  utils.nmap('gi', '<Plug>(coc-implementation)')
  utils.nmap('gr', '<Plug>(coc-references)')
  --- Apply AutoFix to problem on the current line.
  utils.nmap('<leader>qf', '<Plug>(coc-fix-current)')

  vim.cmd([[
    inoremap <silent><expr> <C-c> coc#pum#visible() ? coc#pum#confirm() : "\<C-c>"
  ]])

  function _G.show_docs()
      local cw = vim.fn.expand('<cword>')
      if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
          vim.api.nvim_command('h ' .. cw)
      elseif vim.api.nvim_eval('coc#rpc#ready()') then
          vim.fn.CocActionAsync('doHover')
      else
          vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
      end
  end
  vim.cmd([[
    command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
  ]])
  --- Use K to show documentation in preview window.
  utils.nmap('K', '<CMD>lua _G.show_docs()<CR>')

  --- Rooter
  vim.g.rooter_patterns = {'.git'}

  --- fzf-lua
  utils.nmap('<c-f>', ':FzfLua grep_project<CR>')
  utils.nmap('<c-p>', ':FzfLua files<CR>')
  utils.nmap('<Leader>fw', ':FzfLua grep_cword<CR>')
  utils.nmap('<Leader>fb', ':FzfLua buffers<CR>')
  utils.nmap('<Leader>fm', ':FzfLua marks<CR>')
  utils.nmap('<Leader>fr', ':FzfLua registers<CR>')
  utils.nmap('<Leader>f/', ':FzfLua lines<CR>')
  utils.nmap('<Leader>ft', ':FzfLua tabs<CR>')
  utils.nmap('<Leader>gl', ':FzfLua git_commits<CR>')
  utils.nmap('<Leader>gbl', ':FzfLua git_bcommits<CR>')

  --- Fugitive
  utils.nmap('<leader>gs', ':Git<CR>')
  utils.nmap('<leader>gd', ':Gvdiffsplit<CR>')
  utils.nmap('<leader>gc', ':Git commit<CR>')
  utils.nmap('<leader>gb', ':Git blame<CR>')
  -- nnoremap <silent> <leader>gl :Gclog<CR>
  -- nnoremap <silent> <leader>gp :Git push<CR>
  utils.nmap('<leader>gr', ':Gread<CR>')
  utils.nmap('<leader>gw', ':Gwrite<CR>')
  utils.nmap('<leader>ge', ':Gedit<CR>')
  utils.nmap('<leader>gi', ':Git add -p %<CR>')
  -- Open visual selection in the browser
  utils.vmap('br', ':GBrowse<CR>')
  utils.vmap('b', ':GV<CR>')

  --- TagBar
  utils.nmap('<leader>tt', ':TagbarToggle<CR>')

  --- vimux
  utils.nmap('<Leader>vp', ':VimuxPromptCommand<CR>');
  utils.nmap('<Leader>vs', ':VimuxInterruptRunner<CR>');
  utils.nmap('<Leader>vl', ':VimuxRunLastCommand<CR>');
end)

