module Suckr
    class Sip
        def self.send_register(uri,port,user,domain)
            <<END
REGISTER #{uri} SIP/2.0\r
Via: SIP/2.0/UDP 127.0.0.1:#{port};rport;branch=foo\r
Max-Forwards: 70\r
From: <sip:#{user}@#{domain}>;tag=bar\r
To: <sip:#{user}@#{domain}>\r
Call-ID: bas\r
CSeq: 1 REGISTER\r
User-Agent: SUCKR\r
Contact: <sip:#{user}@127.0.0.1:#{port}>\r
Expires: 300\r
Content-Length:  0\r
END
        end

        def self.send_register_auth(uri,port,user,domain,realm,nonce,response)
            <<END
REGISTER #{uri} SIP/2.0\r
Via: SIP/2.0/UDP 127.0.0.1:#{port};rport;branch=foo\r
Max-Forwards: 70\r
From: <sip:#{user}@#{domain}>;tag=bar\r
To: <sip:#{user}@#{domain}>\r
Call-ID: bas\r
CSeq: 2 REGISTER\r
User-Agent: SUCKR\r
Contact: <sip:#{user}@127.0.0.1:#{port}>\r
Expires: 300\r
Authorization: Digest username="#{user}", realm="#{realm}", nonce="#{nonce}", uri="#{uri}", response="#{response}"\r
Content-Length:  0\r
END
        end
    end
end