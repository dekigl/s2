class Block
  def self.getdata(gw, &block)
    p gw
    data = ["1","2","3"]
    block.call(data)
  end
end

Block.getdata(2) do |data|
  p data
end
