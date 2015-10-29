class Sensor
  def self.retreive_data(block)
    @fuga = block
    
    func = lambda do |result|
      @fuga.call(result)
    end
    Login.login(func)
  end
end

class Login
  def self.login(block)
    block.call(123)
  end
end

getdata = lambda do |result|
  puts(result)
end

Sensor.retreive_data(getdata)
