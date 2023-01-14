# nvim-dansa

Guess the indent from lines of around.

# usage

```lua
local dansa = require('dansa')

-- global settings.
dansa.setup({
  -- The offset to specify how much lines to use.
  scan_offset = 100,

  -- The count for cut-off the indent candidate.
  cutoff_count = 5,

  -- The settings for tab-indentation or when it cannot be guessed.
  default = {
    expandtab = true,
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
    expandtab = false,
    tab = {
      shiftwidth = 4,
    }
  }
})
```

