package = "newproxy"
version = "scm-1"
source = {
   url = "git://github.com/logiceditor-com/newproxy.git",
   branch = "master"
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
         ["newproxy.init"] = "newproxy/init.lua";
      }
   }
}
