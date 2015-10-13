#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'json'
require 'digest/sha2'

$host = '192.168.56.2:3131'
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
      @httpSession = response.header['Set-Cookie'].split(',').join(';')
      p @httpSession
    else
      p response
    end
  end

  def getJson(api)
    uri = URI.parse('http://' + $host + api)
    http = Net::HTTP.new(uri.host, uri.port, nil)
    response = http.get(uri.path, {'Cookie' => @httpSession})
    p response
    response
  end

  def getGeteway(&block)
    doLogin()
    data = getJson('/api/geteway')
    block.call(data)
  end
end

sensor = SensorData.new()

sensor.getGeteway do |gw|
  p gw
end
