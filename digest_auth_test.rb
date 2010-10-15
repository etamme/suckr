#!/usr/bin/env ruby
require 'digest/md5'

require 'testdata/registration_messages'
puts registration.inspect

# ha1 data
user="test"
realm="proxy.uphreak.com"
pass="test"
# ha2 data
method="REGISTER"
uri="sip:proxy.uphreak.com"
nonce="4cb8867c00000073a9a7c0165a3163e3a21c9065f8155260"

def get_response(user,realm,pass,method,uri,nonce)
	# generate a1, ha1
	a1=[user, realm, pass].join(":")
	#puts "a1 = #{a1}"
	ha1 = Digest::MD5::hexdigest(a1)

	# generate a2, ha2
	a2=[method,uri].join(":")
	#puts "a2 = #{a2}"
	ha2 = Digest::MD5::hexdigest(a2)

	# generate response
	request_digest=[ha1,nonce,ha2].join(":")
	#puts "request_digest = #{request_digest}"
	response = Digest::MD5::hexdigest(request_digest)
	return response
end

puts get_response(user,realm,pass,method,uri,nonce)
