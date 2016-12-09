require_relative 'heap2'

class PriorityMap
  attr_reader :map, :queue
  def initialize(&prc)
    @map = {}
    self.queue = BinaryMinHeap.new do |key1, key2|
      prc.call(self.map[key1], self.map[key2])
    end
  end

  def [](key)
    @map[key]
  end

  def []=(key, value)
    if has_key?(key)
      update(key,value)
    else
      insert(key,value)
    end
  end

  def count
    @map.keys.length
  end

  def empty?
    @map.empty?
  end

  def extract
    top = @queue.extract
    value = @map[top]
    @map.delete(top)
    [top,value]
  end

  def has_key?(key)
    !@map[key].nil?
  end

  protected
  attr_accessor :map, :queue

  def insert(key, value)
    @map[key] = value
    @queue.push(key)
  end

  def update(key, value)
    @map[key] = value
    @queue.reduce!(key)
  end
end
