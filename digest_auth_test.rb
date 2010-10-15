#!/usr/bin/env ruby
require 'digest/md5'

# HA1 data
user="test"
realm="proxy.foo.com"
pass="test"

# HA2 data
method="REGISTER"
uri="sip:proxy.foo.com"
nonce="4cb8867c00000073a9a7c0165a3163e3a21c9065f8155260"

# generate A1, HA1
A1=[user, realm, pass].join(":")
puts "A1 = #{A1}"
HA1 = Digest::MD5::hexdigest(A1)

# generate A2, HA2
A2=[method,uri].join(":")
puts "A2 = #{A2}"
HA2 = Digest::MD5::hexdigest(A2)

# generate response
request_digest=[HA1,nonce,HA2].join(":")
puts "request_digest = #{request_digest}"
response = Digest::MD5::hexdigest(request_digest)
puts "response = #{response}"
