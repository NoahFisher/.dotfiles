function ColorMyPencils(color)
  color = color or "catppuccin-mocha"
  vim.cmd("colorscheme " .. color ) -- .colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = "#313244" })
  vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#313244" })
end
ColorMyPencils()
