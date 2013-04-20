#! /usr/bin/env lua

ip9258 = require 'ip9258'

ip = arg[1] or '172.16.163.209'
port = arg[2] or '80'

d1 = ip9258.new(ip, port, 'admin', '12345678')
d1:beeper(0)

state = 1
operations = 0
while true do
   state = 1 - state
   for _, sw in ipairs(d1.switches) do
      sw:set(state)
   end
   operations = operations + 1
   print(operations)
   os.execute('sleep 1')
end

