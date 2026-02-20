-- Normal mode tests.

local t = require('test.testutil')
local n = require('test.functional.testnvim')()
local Screen = require('test.functional.ui.screen')

local clear = n.clear
local feed = n.feed
local fn = n.fn
local command = n.command
local eq = t.eq
local api = n.api

describe('Visual mode', function()
  before_each(clear)

  it('g CTRL-g in visual mode works', function()
    local screen = Screen.new(60, 6)
    api.nvim_buf_set_lines(0, 0, -1, true, { 'abcdefg', 'abcdefg' })
    feed('jlvlg<c-g>')
    screen:expect([[
      abcdefg                                                     |
      a{17:b}^cdefg                                                     |
      {1:~                                                           }|*3
      Selected 1 of 2 Lines; 1 of 2 Words; 2 of 16 Bytes          |
    ]])
  end)
end)
