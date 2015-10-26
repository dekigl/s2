#!/usr/bin/env ruby

require_relative "serveraccess"

server = ServerAccess.new();
gw = server.getData('/api/gateway')
gw.each do |gwid, value|
  api = '/api/sensor?' + 'gateway_id=' + gwid.to_s
  sensor = server.getData(api)
  sensor.each do |sensorid, value|
    name = "sensor" + sensorid.to_s
    data = {sensorid => {:name => name}}
    resp = server.setData('/api/sensor', data)
    p resp
  end
end
