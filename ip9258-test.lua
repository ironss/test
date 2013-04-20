#! /usr/bin/env lua

ip9258 = require 'ip9258'

swid = arg[1]
state = arg[2]

--print(swid, state)

d1 = ip9258.new('172.16.163.208', '80', 'admin', '12345678')
d1:beeper(0)

--s = d1.switch[swid]
--s:set(state)

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

