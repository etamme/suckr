SIP Udp CracKeR  - suckr


ABOUT
-------
suckr is a project im playing with in my spare time because I am interested in ip telephony, SIP and security.  I know sipvicious already exists, but I am writing suckr for a few reasons:

- I wanted to learn more about the underlying mechanisms of SIP authentication and authorization, and there is no better way to learn than get hands on.

- Sipvicious, while nice, seems funky to me.  It does odd things when enumerating "extensions" and is a larger more generic framework than I am interested

- I wanted to build some thing that could be easily scripted to test some of our own systems in house at my job.  Sipvicious doesnt seem to have very friendly mechanisms for capturing the discovered data and feeding it to other applications, or even cleaner output to save to a file.


HOWTO
-------
Right now, you have to edit the vars in the top of suckr.rb that control the user & password ranges to attempt, along with the domain.  This will change shortly.  After you have edited the vars, just run ./suckr.rb


ROADMAP
-------
Right now im writing suckr as a ... hack... a play thing.  I'd like to work towards writing a sip parsing framework for my future tool development, and I'm guessing that suckr will help facilitate the early development of that framework.
