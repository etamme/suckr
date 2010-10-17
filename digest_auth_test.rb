#!/usr/bin/env ruby
require 'digest/md5'

# ---------------------------------------------
# this was just a proof of concept for getting
# the digest auth stuff figured out.  I left
# it here... just because (shrug)
# ---------------------------------------------



# ha1 data
user="test"
realm="proxy.test.com"
pass="test"
# ha2 data
method="REGISTER"
uri="sip:proxy.test.com"
nonce="4cbb1cde00000845271c10292c763c4dff0fef58e0e81046"

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
