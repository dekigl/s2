#!/usr/bin/env ruby
# coding: utf-8

require_relative "serveraccess"

gateways = [{:hardware_uid => "gateway0001", :name => "自宅"},
            {:hardware_uid => "gateway0002", :name => "会社"},
           ]

server = ServerAccess.new();
gateways.each do |gw|
  server.setData('/api/gateway_add', gw)
end
