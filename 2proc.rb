#!/usr/bin/env ruby

proc1 = lambda do |param, proc|
  puts("proc1 ", param)
  proc.call("proc call")
end

proc2 = lambda do |param|
  puts("proc2 ", param)
  10
end

def func(proc1, proc2)
  proc1.call("proc1 call", proc2)
end

data = func(proc1, proc2)
puts data
