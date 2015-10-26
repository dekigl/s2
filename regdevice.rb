#!/usr/bin/env ruby

require_relative "serveraccess"

server = ServerAccess.new();

huid_hash = {'hardware_uid' => '0013a2004066cccf',
             'class_group_code' => '0x00',
             'class_code' => '0x00',
             'properties' => [
               {
                 'class_group_code' => '0x00',
                 'class_code' => '0x00',
                 'property_code'=>'0x30',
                 'type' => 'sensor'},
               {
                 'class_group_code' => '0x00',
                 'class_code' => '0x00',
                 'property_code'=>'0x31',
                 'type' => 'controller'}
             ]}
res = server.setData('/api/device', huid_hash)
p res
json = JSON.parse(res)
p json
