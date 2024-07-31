##
## Proxy environment
##

export HTTP_PROXY="http://127.0.0.1:8118"
export SOCKS_PROXY="socks5://127.0.0.1:1080"

export SOCKS_VERSION="5"

export http_proxy="$HTTP_PROXY"
export HTTPS_PROXY="$HTTP_PROXY"
export https_proxy="$HTTPS_PROXY"
export FTP_PROXY="$HTTP_PROXY"
export ftp_proxy="$FTP_PROXY"
export RSYNC_PROXY="$HTTP_PROXY"
export rsync_proxy="$rsync_proxy"

export NO_PROXY="localhost,127.0.0.1,10.96.0.0/12,192.168.59.0/24,192.168.49.0/24,192.168.39.0/24"
export no_proxy="$NO_PROXY"
