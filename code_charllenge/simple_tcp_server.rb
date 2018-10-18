#require "TCPServer"
require "socket"
include Socket::Constants
class SimpleTCPServer  
  @srv     
  def start1()    
    socket = Socket.new( AF_INET, SOCK_STREAM, 0 )    
    sockaddr = Socket.pack_sockaddr_in( 12345, 'localhost' )    
    socket.bind( sockaddr )    
    socket.listen( 5 )      
  end    

  def start()   
   puts "start"
   @srv  = TCPServer.new("localhost", 12345)      

      socket = @srv.accept      #socket.puts Time.now     
   begin   
     buffer = ""
     word = ""
     while true    
 
      if socket.eof?
        socket = @srv.accept 
      end

       word = socket.gets
       word.strip!
       puts "Client #{socket.to_s} say : #{word}"   
       socket.write "Got you input '#{word}'\n"
      
    end      
   ensure        
    socket.close      
   end      
 end    
 
  def connect()         
     #socket = Socket.new( AF_INET, SOCK_STREAM, 0 )
     #sockaddr = Socket.pack_sockaddr_in( 12345, "localhost")
     #socket.connect( sockaddr )
     socket = TCPSocket.new("localhost", 12345)
     begin
       while true
         input = $stdin.gets
         puts "user input: #{input}"
         socket.write( input )
         reply = socket.gets
         puts "Server says : #{reply} "

       end
     ensure
     socket.close
     end      
   end
end
 
if $0 == __FILE__  

  server = SimpleTCPServer.new()
  
  if ARGV[0] == "client"
    puts ARGV[0]
    server.connect()
  else
    server.start()
  end



end