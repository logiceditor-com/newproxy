local newproxy = require('newproxy')
assert(type(newproxy) == 'function')
assert(type(newproxy()) == 'userdata')

-- TODO: add additional tests based on the Lua 5.1 Manual

print('passed')
