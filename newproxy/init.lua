local newproxy =
{
  _VERSION = '1.1.0';
  _URL = 'https://github.com/logiceditor-com/newproxy';
  _COPYRIGHT = 'Copyright (c) 2020-2021 newproxy rock authors';
  _LICENSE = 'MIT (http://raw.githubusercontent.com/'
          .. 'logiceditor-com/newproxy/master/COPYRIGHT)';
  _DESCRIPTION = 'Lua 5.1\'s newproxy() replacement for future Lua versions';
}

local lua51_newproxy = require 'newproxy.newproxy'
setmetatable(newproxy, {
  __call = function()
    return lua51_newproxy()
  end
})

return newproxy
