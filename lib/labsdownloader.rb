# coding: utf-8
class NiHao

  ## static
  def self.hi
    puts "Nǐ hǎo from static"
  end


  ## instance
  def initialize
    @count = 0
  end

  def get_count
    @count += 1
    return @count
  end

end
