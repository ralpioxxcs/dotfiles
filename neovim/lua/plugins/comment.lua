local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

-- [NORMAL MODE]
-- `gcc` - Toggles the current line using linewise comment
-- `gbc` - Toggles the current line using blockwise comment
-- `gco` - Insert comment to the next line and enters INSERT mode
-- `gcO` - Insert comment to the previous line and enters INSERT mode
-- `gcA` - Insert comment to end of the current line and enters INSERT mod

-- [VISUAL mode]
-- `gc` - Toggles the region using linewise comment
-- `gb` - Toggles the region using blockwise comment

comment.setup {
  ---Add a space b/w comment and the line
  padding = true,

  ---Whether the cursor should stay at its position
  sticky = true,

  ---Lines to be ignored while (un)comment
  ignore = nil,

  ---LHS of operator-pending mappings in NORMAL and VISUAL mode
  opleader = {
    ---Line-comment keymap
    line = "gc",
    ---Block-comment keymap
    block = "gb",
  },
}
