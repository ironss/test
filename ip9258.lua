#! /usr/bin/env lua

-- wget http://admin:12345678@172.16.163.209/Set.cmd?CMD=SetPower+P60=0 -q -O -
-- wget http://admin:12345678@172.16.163.209/Set.cmd?CMD=GetPower+P60=0 -q -O -

local function get(sw)
end 

local function set(sw, status)
   local dev = sw.device
   local cmd = 'Set.cmd?CMD=SetPower+P6' .. sw.swid .. '=' .. status
   dev:command(cmd)
end

local function on(sw)
   sw:set(1)
end

local function off(sw)
   sw:set(0)
end


local function new_switch(device, swid, name)
   local switch = {}
   switch.device = device
   switch.swid = swid
   switch.name = name or device.name .. '.' .. swid
   
   switch.get = get
   switch.set = set
   switch.on  = on
   switch.off = off

   return switch
end


local function new(ip, port, user, pass, name)
   local device = {}
   device.ip = ip
   device.port = port
   device.user = user
   device.pass = pass
   device.name = name or ip .. ':' .. port
   
   device.switches = {}
   for i, swid in ipairs({'0', '1', '2', '3' }) do
      device.switches[i] = new_switch(device, swid)
   end

   device.command = function(dev, cmd)
      local url = 'http://' .. dev.user .. ':' .. dev.pass .. '@' .. dev.ip .. ':' .. dev.port .. '/'
--      local cmdline = 'wget -q -O- --no-http-keep-alive '
      local cmdline = 'curl -s -S -m 2 --no-keepalive '
      cmdline = cmdline .. ' ' .. url .. cmd

		print(cmdline)
		local f = io.popen(cmdline)
		for l in f:lines() do
			print(l)
		end
		f:close()
   end

   device.beeper = function(dev, state)
		local cmd = 'Set.cmd?CMD=SetSetup+BEEPER=' .. state
		dev:command(cmd)
   end

   return device
end


local M = {}
M.new = new

return M

