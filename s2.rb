#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'json'
require 'digest/sha2'

#$host = '192.168.56.2:3131'
$host = 'localhost:3131'
$userauth = {"user" => "hoge", "password" => "fuga"}

class SensorData
  @httpSession = nil

  def doLogin()
    uri = URI.parse('http://' + $host + '/api/login')
    payload = {"username" => $userauth['user'],
               "password_hash" => Digest::SHA256.hexdigest($userauth['password'])}
    request = Net::HTTP::Post.new(uri.path)
    request.body = payload.to_json
    request["Content-Type"] = "application/json"
    http = Net::HTTP.new(uri.host, uri.port, nil)
    response = http.request(request)
    case response
    when Net::HTTPSuccess, Net::HTTPRedirection
      if response.body == "OK"
        #@httpSession = response.header['Set-Cookie'].split(',').join(';')
        @httpSession = response.header['Set-Cookie']
      end
    end
  end

  def getJson(api)
    uri = URI.parse('http://' + $host + api)
    http = Net::HTTP.new(uri.host, uri.port, nil)
    response = http.get(uri, {'Cookie' => @httpSession})
    JSON.parse(response.body)
  end

  def getGeteway(&block)
    doLogin()
    if @httpSession == nil
      p "login failed"
      return
    end
    data = getJson('/api/gateway')
    block.call(data)
  end
end

sensor = SensorData.new()

sensor.getGeteway do |gw|
  gw.each do |gwid, value|
    p gwid
    p value
  end
end
