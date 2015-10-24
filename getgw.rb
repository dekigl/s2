#!/usr/bin/env ruby

require_relative "serveraccess"

server = ServerAccess.new();
gw = server.getData('/api/gateway')
gw.each  do |gwid, value|
  p gwid
  p value
end
  
