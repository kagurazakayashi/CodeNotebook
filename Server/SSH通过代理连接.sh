vim ~/.ssh/config

# Host github.com
# 	ProxyCommand ~/.ssh/ssh-https-tunnel %h %p
# 	Port 443
# 	Hostname ssh.github.com

vim ~/.ssh/ssh-https-tunnel

################################
##  Start User Configuration  ##
################################

# Proxy details
my $host = "127.0.0.1";
my $port = 1081;

# Basic Proxy Authentication - leave empty if you don't need it
# my $user = "username";
# my $pass = "userpass";

# Add an entry to your ~/.ssh/config that so "ssh remote.example.org"
# uses this program to proxy the connection.
#
#    host remote.example.org
#        ProxyCommand /path/to/ssh-https-tunnel %h %p
#        Port 443
#        ServerAliveInterval 10
#
# The last option enables Keep Alives to avoid the problem of many
# proxies timing out inactive connections.  Check your ssh client's
# documentation for details.
#
# If you are behind a Microsoft ISA server, or similar proxy that uses
# NTLM, see http://www.google.com/search?q=ntlm+proxy+auth for ideas.

################################
##   End User Configuration   ##
################################

# https://blog.csdn.net/x6_9x/article/details/60873021