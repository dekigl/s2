#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'json'
require 'digest/sha2'

$host = '192.168.56.2:3131'
$userauth = {"user" => "hoge", "password" => "fuga"}


class SensorData
  @authCookie = nil

  def doLogin()
    uri = URI.parse('http://' + $host + '/api/login')
    #uri = URI.parse('http://' + $host + '/login')
    request = Net::HTTP::Post.new(uri.path)
    request["Content-Type"] = "application/json"
    authdata = {"username" => $userauth['user'],
      "password_hash" => Digest::SHA256.hexdigest($userauth['password'])}
    request.body = authdata.to_json
    response = Net::HTTP.new(uri.host, uri.port).start do |http|
      p http
      p request
      http.request(request)
    end
    case response
    when Net::HTTPSuccess, Net::HTTPRedirection
      @authCookie = response.headers['Set-Cookie']
      p @authCookie
    else
      p "error!"
    end
  end

  def getGeteway(&block)
    doLogin()
    p @authCookie
    data = {"gw#0" => "1", "gw#1" => "2"}
    block.call(data)
  end
end

sensor = SensorData.new()

sensor.getGeteway do |gw|
  p gw
end
