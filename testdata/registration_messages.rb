registration={}
registration[:register1]=<<END 
REGISTER sip:proxy.uphreak.com SIP/2.0\r\n
Via: SIP/2.0/UDP 192.168.0.35:5060;rport;branch=z9hG4bKPj9qcxnZfPa5P4BesM.OOLlF.4jdpwjNKC\r\n
Route: <sip:proxy.uphreak.com;lr>\r\n
Max-Forwards: 70\r\n
From: <sip:test@proxy.uphreak.com>;tag=1.s3-cU85m-hiEg.KDb5gE3lZNkaalsr\r\n
To: <sip:test@proxy.uphreak.com>\r\n
Call-ID: 2RVJY4xZ4qq5xe2Glv9tII94CsJBG4Rq\r\n
CSeq: 24879 REGISTER\r\n
User-Agent: PJSUA v1.6/x86_64-unknown-linux-gnu\r\n
Contact: <sip:test@192.168.0.35:5060>\r\n
Expires: 300\r\n
Content-Length:  0\r\n
END

registration[:unauthorized]=<<END 
SIP/2.0 401 Unauthorized\r\n
Via: SIP/2.0/UDP\r\n 192.168.0.35:5060;rport=36410;branch=z9hG4bKPj9qcxnZfPa5P4BesM.OOLlF.4jdpwjNKC;received=173.210.1.18\r\n
From: <sip:test@proxy.uphreak.com>;tag=1.s3-cU85m-hiEg.KDb5gE3lZNkaalsr\r\n
To: <sip:test@proxy.uphreak.com>;tag=fcbb86e90d41011b00912bb35729895f.3a82\r\n
Call-ID: 2RVJY4xZ4qq5xe2Glv9tII94CsJBG4Rq\r\n
CSeq: 24879 REGISTER\r\n
WWW-Authenticate: Digest realm="proxy.uphreak.com", nonce="4cb8867c00000073a9a7c0165a3163e3a21c9065f8155260"\r\n
Server: OpenSIPS (1.6.3-notls (x86_64/linux))\r\n
Content-Length: 0\r\n
END

registration[:register2]=<<END 
REGISTER sip:proxy.uphreak.com SIP/2.0\r\n
Via: SIP/2.0/UDP 192.168.0.35:5060;rport;branch=z9hG4bKPj5lARe1CyNId82IOKFqhn4rol48jzDSdm\r\n
Route: <sip:proxy.uphreak.com;lr>\r\n
Max-Forwards: 70\r\n
From: <sip:test@proxy.uphreak.com>;tag=1.s3-cU85m-hiEg.KDb5gE3lZNkaalsr\r\n
To: <sip:test@proxy.uphreak.com>\r\n
Call-ID: 2RVJY4xZ4qq5xe2Glv9tII94CsJBG4Rq\r\n
CSeq: 24880 REGISTER\r\n
User-Agent: PJSUA v1.6/x86_64-unknown-linux-gnu\r\n
Contact: <sip:test@192.168.0.35:5060>\r\n
Expires: 300\r\n
Authorization: Digest username="test", realm="proxy.uphreak.com", nonce="4cb8867c00000073a9a7c0165a3163e3a21c9065f8155260", uri="sip:proxy.uphreak.com"\r\n response="d9d104a935359c9d7334a80a1cfdd123"\r\n
Content-Length:  0\r\n
END

registration[:ok]=<<END 
SIP/2.0 200 OK\r\n
Via: SIP/2.0/UDP\r\n 192.168.0.35:5060;rport=36410;branch=z9hG4bKPj5lARe1CyNId82IOKFqhn4rol48jzDSdm;received=173.210.1.18\r\n
From: <sip:test@proxy.uphreak.com>;tag=1.s3-cU85m-hiEg.KDb5gE3lZNkaalsr\r\n
To: <sip:test@proxy.uphreak.com>;tag=fcbb86e90d41011b00912bb35729895f.42df\r\n
Call-ID: 2RVJY4xZ4qq5xe2Glv9tII94CsJBG4Rq\r\n
CSeq: 24880 REGISTER\r\n
Contact: <sip:test@192.168.0.35:5060>;expires=300;received="sip:173.210.1.18:36410"\r\n
Server: OpenSIPS (1.6.3-notls (x86_64/linux))\r\n
Content-Length: 0\r\n
END
