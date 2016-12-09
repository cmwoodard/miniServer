require 'socket'      # Sockets are in standard library

hostname = 'localhost'
port = 2345

s = TCPSocket.open(hostname, port)
s.puts "This message should show on the server"

puts s.read
#s.close   