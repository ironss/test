#! /usr/bin/env lua

ip9258 = require 'ip9258'

switch = arg[1]
state = arg[2]

sw1 = ip9258.new('172.16.163.208', '80', 'admin', '12345678', switch)
sw1:set(state)

sw2 = ip9258.new('172.16.163.209', '80', 'admin', '12345678', switch)
-- sw2:set(state)

