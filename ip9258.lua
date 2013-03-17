#! /usr/bin/env lua

-- wget http://admin:12345678@172.16.163.209/Set.cmd?CMD=SetPower+P60=0 -q -O -
-- wget http://admin:12345678@172.16.163.209/Set.cmd?CMD=GetPower+P60=0 -q -O -
 
 
local function set(dev, status)
   local cmd = 'wget http://' .. dev.user .. ':' .. dev.pass .. '@' .. dev.ip .. ':' .. dev.port .. '/Set.cmd?CMD=SetPower+P6' .. dev.switch .. '=' .. status .. ' -q -O-'
   print(cmd)
   local f = io.popen(cmd)
   local r = f:read('*a')
   print(r)
end

local function on(dev)
   dev:set(1)
end

local function off(dev)
   dev:set(0)
end


local function get(device)
end



local function new(ip, port, user, pass, switch)
   local t = {}
   t.ip = ip
   t.port = port
   t.user = user
   t.pass = pass
   t.switch = switch
  
   t.set = set
   t.get = get
 
   return t
end

local M = {}
M.new = new

return M

