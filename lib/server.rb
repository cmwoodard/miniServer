require 'socket'
require 'json'

ip = 'localhost'
port = 2000
server = TCPServer.open(ip, port)

loop{		
	Thread.start(server.accept) do |client|
		#http request(hopefully)
		request =  client.read.
		request_array = request.split()
		response_code = 200
		response_message = "OK"
		request_type = request_array[0]
		requested_file = "lib/#{request_array[1]}"
		http_v = request_array[2]
		header_size = 0
		index = ""
		#headers,body = request.split("\r\n\r\n", 2)
		puts request_type
		puts requested_file
		
		case request_type
			when "GET"			
				if File.exist?(requested_file)				
					index = File.open(requested_file, "r").read
					header_size = index.length

				else
					response_code = 404
					response_message = "File Not Found"
					header_size = 0
				end
				client.puts "#{http_v} #{response_code} #{response_message}\r\n\r\n "
				client.puts "Content-Length: #{header_size}\r\n\r\n"
				client.puts "#{index}"
			when "HEAD"
				client.puts "This is a HEAD request"
			when "POST"
				#puts request_type				 
				#puts "Headers: #{headers}\r\n\r\n Body: #{body}"
				puts request.inspect
			else
		end		
		client.close
	end
}
