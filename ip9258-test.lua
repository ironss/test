#! /usr/bin/env lua

ip9258 = require 'ip9258'

d1 = ip9258.new('172.16.163.209', '80', 'admin', '12345678')
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

