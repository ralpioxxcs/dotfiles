return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  opts = {
    options = {
      numbers = "ordinal", --  "none" | "ordinal" | "buffer_id" | "both"

      close_icon = "",
      buffer_close_icon = "",
      modified_icon = "●",

      show_buffer_close_icons = true,
      show_close_icon = true,

      separator_style = "padded_thin", -- "slant", "padded_slant", "thick", "thin", "padded_thin"

      -- LSP 진단(에러, 경고) 표시 활성화
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level == vim.diagnostic.severity.ERROR and " "
          or (level == vim.diagnostic.severity.WARN and " " or " ")
        return icon .. count
      end,

      -- NvimTree와 같은 파일 탐색기 사용 시 여백 추가
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "left",
          separator = true,
        },
      },
      -- 버퍼가 하나만 있어도 항상 버퍼라인 표시
      always_show_bufferline = true,
    },
  },
  -- 키맵 설정
  keys = {
    {
      "<Tab>",
      "<cmd>BufferLineCycleNext<cr>",
      desc = "Next buffer",
    },
    {
      "<S-Tab>",
      "<cmd>BufferLineCyclePrev<cr>",
      desc = "Prev buffer",
    },
    {
      "<leader>c",
      "<cmd>bdelete<cr>",
      desc = "Close current buffer",
    },
    -- 특정 버퍼로 바로 이동 (1~9)
    {
      "<leader>1",
      "<cmd>BufferLineGoToBuffer 1<cr>",
      desc = "Go to buffer 1",
    },
    {
      "<leader>2",
      "<cmd>BufferLineGoToBuffer 2<cr>",
      desc = "Go to buffer 2",
    },
    {
      "<leader>3",
      "<cmd>BufferLineGoToBuffer 3<cr>",
      desc = "Go to buffer 3",
    },
    {
      "<leader>4",
      "<cmd>BufferLineGoToBuffer 4<cr>",
      desc = "Go to buffer 4",
    },
    {
      "<leader>5",
      "<cmd>BufferLineGoToBuffer 5<cr>",
      desc = "Go to buffer 5",
    },
    {
      "<leader>6",
      "<cmd>BufferLineGoToBuffer 6<cr>",
      desc = "Go to buffer 6",
    },
    {
      "<leader>7",
      "<cmd>BufferLineGoToBuffer 7<cr>",
      desc = "Go to buffer 7",
    },
    {
      "<leader>8",
      "<cmd>BufferLineGoToBuffer 8<cr>",
      desc = "Go to buffer 8",
    },
    {
      "<leader>9",
      "<cmd>BufferLineGoToBuffer 9<cr>",
      desc = "Go to buffer 9",
    },
    {
      "<leader>$",
      "<cmd>BufferLineGoToBuffer -1<cr>",
      desc = "Go to last buffer",
    },
  },
}
