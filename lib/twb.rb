require 'socket'
require 'json'

ip = 'localhost'
port = 2345
path = "index.html"
r_type = "GET"
vikings = Hash.new
vikings[:viking] = Hash.new
content_length = 0

#system("cls")

socket = TCPSocket.open( ip, port )
print "What kind of data would you like to send?\r\n
1. GET
2. POST\n\n->"

 case gets.chomp.to_i
	 when 1
		system("cls")		 
		request = "#{r_type} #{path} HTTP/1.0"	
		print "Requested: #{request}\n"
		socket.print "#{request}\n"		 
	 when 2
		 r_type = "POST"
		 path = "thanks.html"
		 system("cls")
		 print "Viking Registration...\r\n\r"
		 print "What is your viking's name?\n"
		 print "->"
		
		 vikings[:viking][:name] = gets.chomp
		
		 print "What is your viking's email address?\n"
		 print "->"
		 vikings[:viking][:email] = gets.chomp
		 
		 socket.print "#{r_type} #{path} HTTP/1.0\r\n" +
			   "Content-Type: JSON\r\n" +
			   "Content-Length: #{vikings.to_json.bytesize}\r\n"
		 
		 socket.print "\r\n"
		 #request = "#{r_type} #{path} HTTP/1.0"
		 #content_length = vikings.to_json.bytesize
		 #socket.puts request
		 socket.print "#{vikings.to_json}"
		 #socket.puts "Content-Length: #{content_length}"
		
	else
	puts "Invalid type"
 end

#request = "test"

response = socket.read
puts response
#puts response
#headers,body = response.split("\r\n\r\n", 1)
		 #puts headers, "\n#{body}"






