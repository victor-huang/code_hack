

class Random
  
  
  def initialize()
    @cnt = 0
    @a = 0xffffda61
    @previouse_x = (Time.now.to_f * 1000).to_i
  end

  
  def GetRand()
    
    if @cnt == 0 
      x = (Time.now.to_f * 1000).to_i  & 0xffffffff
    else
      x = @previouse_x
    end
    
    @cnt += 1
    @previouse_x = NextInt(x)
    
    @previouse_x << 32
  end

  def NextInt(x)

    
    puts "x mod 2^32 "
    puts x
    tmp = x & 0xffffffff
    108.downto(0) do |n| print tmp[n] end
    x = @a * ( x & 0xffffffff ) + (x >> 32)

    
    return x
  end
  
  def simple_gen()
    c = 13
    b = 2 ** 10 +3
    
    x = ( @a * @previouse_x + c ) % b
    
    @previouse_x = x
  end

end


if $0 == __FILE__

   rand = Random.new()
  30.times do |i|
    puts rand.simple_gen()  % 10
    
  end
end