local colors = require('catppuccin.palettes').get_palette('mocha');


require('scrollbar').setup({
  handle = {
    color = colors.surface1,
    text = ' ',
  },
  marks = {
    Search = { color = colors.orange },
    Error = { color = colors.error },
    Warn = { color = colors.warning },
    Info = { color = colors.info },
    Hint = { color = colors.hint },
    Misc = { color = colors.purple },
  },
  handlers = {
    cursor = false, -- Show dot representing cursor
    handle = true,  -- Hide "drag" handle
  }
})

































































-- ... to test the scrollbar 😅
