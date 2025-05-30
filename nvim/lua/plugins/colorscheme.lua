return {
  {
    "Tsuzat/NeoSolarized.nvim",
    lazy = true,
    -- opts = {
    --   style = "light",
    --   transparent = false,
    -- },
  },

  {
    "projekt0n/github-nvim-theme",
    lazy = true, -- Load theme eagerly on startup
  },

  {
    "ellisonleao/gruvbox.nvim",
    lazy = true, -- Load theme eagerly on startup
    opts = {
      -- Mapped from your original 'setup' table
      italic = {
        strings = true,
        operators = false,
        comments = true,
      },
      contrast = "hard",
    },
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = true, -- Load theme eagerly on startup
  },

  {
    "xero/miasma.nvim",
    lazy = true,
  },

  -- {
  --
  --   "folke/tokyonight.nvim",
  --   lazy = true,
  --   opts = {
  --     style = "moon", -- Styles: "storm", "night", "day", "moon"
  --     styles = {
  --       comments = { italic = true },
  --       keywords = { italic = false },
  --     },
  --   },
  -- },
}
