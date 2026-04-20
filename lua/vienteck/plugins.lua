return {
	{
		"zbirenbaum/copilot.lua",
	},
 --Dotnet STuff
-- lazy.nvim
{
  "GustavEikaas/easy-dotnet.nvim",
  -- 'nvim-telescope/telescope.nvim' or 'ibhagwan/fzf-lua' or 'folke/snacks.nvim'
  -- are highly recommended for a better experience
  dependencies = { "nvim-lua/plenary.nvim", 'mfussenegger/nvim-dap', 'folke/snacks.nvim', },
  config = function()
    local dotnet = require("easy-dotnet")
    -- Options are not required
    dotnet.setup({
     managed_terminal = {
       auto_hide = true, -- auto hides terminal if exit code is 0
       auto_hide_delay = 1000, -- delay before auto hiding, 0 = instant
     },
      -- Optional configuration for external terminals (matches nvim-dap structure)
      external_terminal = nil,
      lsp = {
        enabled = true, -- Enable builtin roslyn lsp
        set_fold_expr = false,
        preload_roslyn = true, -- Start loading roslyn before any buffer is opened
        roslynator_enabled = true, -- Automatically enable roslynator analyzer
        easy_dotnet_analyzer_enabled = true, -- Enable roslyn analyzer from easy-dotnet-server
        auto_refresh_codelens = true,
        analyzer_assemblies = {}, -- Any additional roslyn analyzers you might use like SonarAnalyzer.CSharp
        config = {},
      },
      debugger = {
        -- Path to custom coreclr DAP adapter
        -- easy-dotnet-server falls back to its own netcoredbg binary if bin_path is nil
        bin_path = nil,
        console = "integratedTerminal", -- Controls where the target app runs: "integratedTerminal" (Neovim buffer) or "externalTerminal" (OS window)
        apply_value_converters = true,
        auto_register_dap = true,
        mappings = {
          open_variable_viewer = { lhs = "T", desc = "open variable viewer" },
        },
      },
      ---@type TestRunnerOptions
      test_runner = {
        auto_start_testrunner = true,
        hide_legend = false,
        ---@type "split" | "vsplit" | "float" | "buf"
        viewmode = "float",
        ---@type number|nil
        vsplit_width = nil,
        ---@type string|nil "topleft" | "topright" 
        vsplit_pos = nil,
        icons = {
          passed = "",
          skipped = "",
          failed = "",
          success = "",
          reload = "",
          test = "",
          sln = "󰘐",
          project = "󰘐",
          dir = "",
          package = "",
          class = "",
          build_failed = "󰒡",
        },
        mappings = {
          run_test_from_buffer = { lhs = "<leader>r", desc = "run test from buffer" },
          run_all_tests_from_buffer = { lhs = "<leader>t", desc = "Run all tests in file" },
          get_build_errors = { lhs = "<leader>e", desc = "get build errors" },
          peek_stack_trace_from_buffer = { lhs = "<leader>p", desc = "peek stack trace from buffer" },
          debug_test_from_buffer = { lhs = "<leader>d", desc = "run test from buffer" },
          debug_test = { lhs = "<leader>d", desc = "debug test" },
          go_to_file = { lhs = "g", desc = "go to file" },
          run_all = { lhs = "<leader>R", desc = "run all tests" },
          run = { lhs = "<leader>r", desc = "run test" },
          peek_stacktrace = { lhs = "<leader>p", desc = "peek stacktrace of failed test" },
          expand = { lhs = "o", desc = "expand" },
          expand_node = { lhs = "E", desc = "expand node" },
          collapse_all = { lhs = "W", desc = "collapse all" },
          close = { lhs = "q", desc = "close testrunner" },
          refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" },
          cancel = { lhs = "<C-c>", desc = "cancel in-flight operation" },
        }
      },
      new = {
        project = {
          prefix = "sln" -- "sln" | "none"
        }
      },
      csproj_mappings = true,
      fsproj_mappings = true,
      auto_bootstrap_namespace = {
          --block_scoped, file_scoped
          type = "block_scoped",
          enabled = true,
          use_clipboard_json = {
            behavior = "prompt", --'auto' | 'prompt' | 'never',
            register = "+", -- which register to check
          },
      },
      server = {
          ---@type nil | "Off" | "Critical" | "Error" | "Warning" | "Information" | "Verbose" | "All"
          log_level = nil,
      },
      -- choose which picker to use with the plugin
      -- possible values are "telescope" | "fzf" | "snacks" | "basic"
      -- if no picker is specified, the plugin will determine
      -- the available one automatically with this priority:
      --  snacks -> fzf -> telescope ->  basic
      picker = "snacks",
      background_scanning = true,
      notifications = {
        --Set this to false if you have configured lualine to avoid double logging
        handler = function(start_event)
          local spinner = require("easy-dotnet.ui-modules.spinner").new()
          spinner:start_spinner(start_event.job.name)
          ---@param finished_event JobEvent
          return function(finished_event)
            spinner:stop_spinner(finished_event.result.msg, finished_event.result.level)
          end
        end,
      },
      diagnostics = {
        default_severity = "error",
        setqflist = false,
      },
    })

    -- Example command
    vim.api.nvim_create_user_command('Secrets', function()
      dotnet.secrets()
    end, {})

    -- Example keybinding
    vim.keymap.set("n", "<C-p>", function()
      dotnet.run_project()
    end)
  end
},
	--DEBUGGER
	{ "folke/neodev.nvim", opts = {} },
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			handlers = {},
		},
	},
	--PYTHON DEBUGGER
	{
		"mfussenegger/nvim-dap-python",
		lazy = true,
	},
	--GOLANG DEBUGGER
	{
		"leoluz/nvim-dap-go",
		lazy = true,
	},
	{
		"nvim-telescope/telescope-dap.nvim",
	},
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		dependencies = {
			{ "mfussenegger/nvim-dap" },
			{ "nvim-neotest/nvim-nio" },
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	--themes
	{ "nvim-lualine/lualine.nvim", dependencies = "nvim-tree/nvim-web-devicons" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "storm",
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},
	{ "rebelot/kanagawa.nvim" },
	{ "olimorris/onedarkpro.nvim" },
	--syntax, highlights and formatting
	{ "ap/vim-css-color" },
	{ "tpope/vim-commentary" },
	{ "tpope/vim-surround" },
	{ "jose-elias-alvarez/null-ls.nvim", lazy = false, dependencies = { "nvim-lua/plenary.nvim" } },
	{ "ziglang/zig.vim", lazy = false },
	--UI plugins
	{ "scrooloose/nerdtree" },
	{ "m4xshen/autoclose.nvim" }, -- Used to autoclose characters like (){}[]
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	--treesitter
	{ "windwp/nvim-ts-autotag" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{ "nvim-treesitter/nvim-treesitter-context" },
	{ "theprimeagen/harpoon" },
	{ "mbbill/undotree" },
	--git stuff
	{ "tpope/vim-fugitive" },
	{ "airblade/vim-gitgutter" },
	--lsp server packages
	{
		{
			"VonHeikemen/lsp-zero.nvim",
			branch = "v4.x",
			lazy = true,
			config = false,
		},
		{
			"williamboman/mason.nvim",
			lazy = false,
			config = true,
		},

		-- Autocompletion
		{
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
				{ "L3MON4D3/LuaSnip" },
			},
			config = function()
				local cmp = require("cmp")
				cmp.setup({
					sources = {
						{ name = "nvim_lsp" },
					},
					mapping = cmp.mapping.preset.insert({
						["<C-Space>"] = cmp.mapping.complete(),
						["<C-u>"] = cmp.mapping.scroll_docs(-4),
						["<C-d>"] = cmp.mapping.scroll_docs(4),
					}),
					snippet = {
						expand = function(args)
							vim.snippet.expand(args.body)
						end,
					},
				})
			end,
		},
		-- LSP
		{
			"neovim/nvim-lspconfig",
			cmd = { "LspInfo", "LspInstall", "LspStart" },
			event = { "BufReadPre", "BufNewFile" },
			dependencies = {
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "williamboman/mason.nvim" },
				{ "williamboman/mason-lspconfig.nvim" },
			},
			config = function()
				local lsp_zero = require("lsp-zero")

				-- lsp_attach is where you enable features that only work
				-- if there is a language server active in the file
				local lsp_attach = function(client, bufnr)
					local opts = { buffer = bufnr }
					vim.keymap.set("n", "<leader>K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
					vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
					vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
					vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
					vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
					vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
					vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
					vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
				end

				lsp_zero.extend_lspconfig({
					sign_text = true,
					lsp_attach = lsp_attach,
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
				})

				require("mason-lspconfig").setup({
					ensure_installed = {
						zls,
					},
					handlers = {
						-- this first function is the "default handler"
						-- it applies to every language server without a "custom handler"
						function(server_name)
							vim.lsp.config(server_name, {})
							vim.lsp.enable(server_name)
						end,
					},
				})
			end,
		},
	},
}
