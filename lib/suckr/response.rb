module Suckr
    class Response
        # this function generates the response to a auth request
        def self.create(user,realm,pass,uri,nonce)
          # generate a1, ha1
          a1=[user, realm, pass].join(":")
          ha1 = Digest::MD5::hexdigest(a1)

          # generate a2, ha2
          a2=["REGISTER",uri].join(":")
          ha2 = Digest::MD5::hexdigest(a2)

          # generate response
          request_digest=[ha1,nonce,ha2].join(":")
          puts "request_digest = #{request_digest}"
          Digest::MD5::hexdigest(request_digest)
        end
    end
end