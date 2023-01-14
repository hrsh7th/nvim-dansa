# nvim-dansa

Guess the indent from lines of around.

# usage

```lua
local dansa = require('dansa')

-- global settings.
dansa.setup({
  -- The threshold for how much to scan above and below the cursor line
  threshold = 100,

  -- The settings for tab-indentation or when it cannot be guessed.
  default = {
    expandtab = false,
    space = {
      shiftwidth = 2,
    },
    tab = {
      shiftwidth = 4,
    }
  }
})

-- per filetype settings.
dansa.setup.filetype('go', {
  default = {
    expandtab = true,
    tab = {
      shiftwidth = 4,
    }
  }
})
```

