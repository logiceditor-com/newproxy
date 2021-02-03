--------------------------------------------------------------------------------
-- rockspec/generate.lua: lua-crontab dumb rockspec generator
-- This file is a part of lua-crontab library
-- Copyright (c) lua-crontab authors (see file `COPYRIGHT` for the license)
--------------------------------------------------------------------------------

pcall(require, 'luarocks.require') -- Ignoring errors

local lfs = require 'lfs'

-- From lua-aplicado.
local function find_all_files(path, regexp, dest, mode)
  dest = dest or {}
  mode = mode or false

  assert(mode ~= "directory")

  for filename in lfs.dir(path) do
    if filename ~= "." and filename ~= ".." then
      local filepath = path .. "/" .. filename
      local attr = lfs.attributes(filepath)
      if attr.mode == "directory" then
        find_all_files(filepath, regexp, dest)
      elseif not mode or attr.mode == mode then
        if filename:find(regexp) then
          dest[#dest + 1] = filepath
          -- print("found", filepath)
        end
      end
    end
  end

  return dest
end

local files = find_all_files("newproxy", "^.*%.lua$")
table.sort(files)

local version = select(1, ...) or "scm-1"
local branch = select(2, ...) or "master"

io.stdout:write([[
package = "newproxy"
version = "]] .. version .. [["
source = {
   url = "git://github.com/logiceditor-com/newproxy.git",
   branch = "]] .. branch .. [["
}
description = {
   summary = "Lua 5.1's newproxy() replacement for future Lua versions",
   homepage = "http://logiceditor.com",
   license = "MIT/X11",
   maintainer = "LogicEditor Team <team@logiceditor.com>"
}
dependencies = {
   "lua >= 5.1, <= 5.4"
}
build = {
   type = "builtin",
   modules = {
      ["newproxy.newproxy"] = {
         sources = { "newproxy/newproxy.c" }
      }
   },
   install = {
      lua = {
]])

for i = 1, #files do
  local name = files[i]
  io.stdout:write([[
         []] .. (
          ("%q"):format(
              name:gsub("/", "."):gsub("\\", "."):gsub("%.lua$", "")
            )
        ) .. [[] = ]] .. (("%q"):format(name)) .. [[;
]])
end

io.stdout:write([[
      }
   }
}
]])
io.stdout:flush()
