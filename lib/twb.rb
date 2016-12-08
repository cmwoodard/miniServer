require 'socket'
require 'json'

ip = 'localhost'
port = 2000
path = "index.html"
r_type = "GET"
vikings = Hash.new
vikings[:viking] = Hash.new
content_length = 0

system("cls")

socket = TCPSocket.open( ip, port )
print "What kind of data would you like to send?\r\n
1. GET
2. POST\n\n->"

case gets.chomp.to_i
	when 1
		system("cls")
		request = "#{r_type} #{path} HTTP/1.0\r\n\r\n"
		puts request
		socket.print(request)
		response = socket.read
		#headers,body = response.split("\r\n\r\n", 2) 
		print response
		#socket.close
	when 2
		r_type = "POST"
		system("cls")
		print "Viking Registration...\r\n\r"
		print "What is your viking's name?\n"
		print "->"
		
		vikings[:viking][:name] = gets.chomp
		
		print "What is your viking's email address?\n"
		print "->"
		vikings[:viking][:email] = gets.chomp
		request = "#{r_type} #{path} HTTP/1.0\r\n\r\n"
		content_length = vikings.to_json.length
		socket.puts request
		socket.puts "Content-Length: #{content_length} \r\n\r\n"
		socket.puts(vikings.to_json)
	else
	puts "Invalid type"
end
	








