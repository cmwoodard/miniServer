require 'socket' # Provides TCPServer and TCPSocket classes
require 'json'
# Initialize a TCPServer object that will listen
# on localhost:2345 for incoming connections.
server = TCPServer.new('localhost', 2345)

# loop infinitely, processing one incoming
# connection at a time.

loop do
	
	# Wait until a client connects, then return a TCPSocket
	# that can be used in a similar fashion to other Ruby
	# I/O objects. (In fact, TCPSocket is a subclass of IO.)
	socket = server.accept

	# Read the first line of the request (the Request-Line)
	request = socket.recv(1012)
		
	headers,body = request.split("\r\n\r\n", 2)
	header_array = headers.split("\r\n")
	
	request_array = header_array[0].split()
	response_code = 200
	response_message = "OK"
	request_type = request_array[0]
	requested_file = "lib/#{request_array[1]}"
	http_v = request_array[2]
	
	# header_size = 0
	
	#STDERR.puts request
	STDERR.puts request
	

	
	if request_type == "GET"
		if File.file?(requested_file)
			puts "FILE FOUND"
			file = File.open("#{requested_file}", "r").read
		else
			puts "FILE NOT FOUND"
			response_code = 404
			response_message = "File Not Found"
		end		
		response = "#{file}"

		elsif request_type == "POST"
			file = File.open("#{requested_file}", "r").read
			params = JSON.parse(body)
			response =  file.gsub("<%= yield %>", "<li>#{params["viking"]["name"]}</li><li>#{params["viking"]["email"]}</li>")
						
		else
			response = "no go, error"
	end

	# We need to include the Content-Type and Content-Length headers
	# to let the client know the size and type of data
	# contained in the response. Note that HTTP is whitespace
	# sensitive, and expects each header line to end with CRLF (i.e. "\r\n")	
	socket.print "#{http_v} #{response_code} #{response_message}\r\n" +
			   "Content-Type: text/plain\r\n" +
			   "Content-Length: #{response.bytesize}\r\n" +
			   "Connection: close\r\n"

	# Print a blank line to separate the header from the response body,
	# as required by the protocol.
	socket.print "\r\n"

	# Print the actual response body
	socket.puts "#{response}"
	
	#socket.print request_array

	# Close the socket, terminating the connection
	socket.close
end
