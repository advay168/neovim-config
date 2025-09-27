-- require("snacks") -- For type inference
return
{
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {},
      explorer = {},
    },
    keys = {
      { "<leader>s",       function() Snacks.picker() end,                       desc = "Snacks picker" },
      -- Top Pickers & Explorer
      { "<leader><space>", function() Snacks.picker.smart() end,                 desc = "Smart Find Files" },
      { "<leader>/",       function() Snacks.picker.grep() end,                  desc = "Grep" },
      { "<leader>e",       function() Snacks.explorer() end,                     desc = "File Explorer" },
      -- find
      { "<leader>fb",      function() Snacks.picker.buffers() end,               desc = "Buffers" },
      { "<leader>fg",      function() Snacks.picker.git_files() end,             desc = "Find Git Files" },
      { "<leader>fG",      function() Snacks.picker.files() end,                 desc = "Find Files" },
      { "<leader>fp",      function() Snacks.picker.projects() end,              desc = "Projects" },
      { "<leader>fr",      function() Snacks.picker.recent() end,                desc = "Recent" },
      --
      -- git
      -- { "<leader>gb",      function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
      -- { "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
      -- { "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
      -- { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
      -- { "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
      -- { "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
      -- { "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
      --
      -- Grep
      { "<leader>sb",      function() Snacks.picker.grep_buffers() end,          desc = "Grep Open Buffers" },
      { "<leader>sB",      function() Snacks.picker.lines() end,                 desc = "Buffer Lines" },
      { "<leader>sw",      function() Snacks.picker.grep_word() end,             desc = "Visual selection or word", mode = { "n", "x" } },
      -- search
      { "<leader>sa",      function() Snacks.picker.autocmds() end,              desc = "Autocmds" },
      { "<leader>sb",      function() Snacks.picker.lines() end,                 desc = "Buffer Lines" },
      { "<leader>sc",      function() Snacks.picker.command_history() end,       desc = "Command History" },
      { "<leader>sC",      function() Snacks.picker.commands() end,              desc = "Commands" },
      { "<leader>sd",      function() Snacks.picker.diagnostics() end,           desc = "Diagnostics" },
      { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,    desc = "Buffer Diagnostics" },
      { "<leader>sh",      function() Snacks.picker.help() end,                  desc = "Help Pages" },
      { "<leader>sH",      function() Snacks.picker.highlights() end,            desc = "Highlights" },
      { "<leader>sj",      function() Snacks.picker.jumps() end,                 desc = "Jumps" },
      { "<leader>sk",      function() Snacks.picker.keymaps() end,               desc = "Keymaps" },
      { "<leader>sm",      function() Snacks.picker.marks() end,                 desc = "Marks" },
      { "<leader>sp",      function() Snacks.picker.lazy() end,                  desc = "Search for Plugin Spec" },
      { "<leader>sR",      function() Snacks.picker.resume() end,                desc = "Resume" },
      { "<leader>su",      function() Snacks.picker.undo() end,                  desc = "Undo History" },
      { "<leader>uC",      function() Snacks.picker.colorschemes() end,          desc = "Colorschemes" },
      -- LSP
      { "gd",              function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
      { "gD",              function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
      { "grr",             function() Snacks.picker.lsp_references() end,        desc = "References" },
      { "gri",             function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
      { "gy",              function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
      { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
      { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    }
  }
}
