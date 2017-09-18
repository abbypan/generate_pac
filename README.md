# generate_pac
自动更新pac代理文件

# 安装　

以debian环境为例

    apt-get install tcpdump tshark

# generate_pac.pl

示例

    perl generate_pac.pl [pac_fname] [socks_ip_port] [white] [black]

    perl generate_pac.pl local.pac 127.0.0.1:8888 dom_white.txt dom_black.txt

pac_fname 生成的目标pac文件

socks_ip_port 本地socks5代理ip及端口

white 不走socks5代理的域名列表文件，例如　*.cn 域名

black 走socks5代理的域名列表文件，例如 *.google.com 域名

默认走socks5代理

# extract_new_dom.pl 

本地域名抓包

    sudo tcpdump port 53 -s0 -w dns53.pcap 

示例

    perl extract_new_dom.pl [dom_pcap] [white] [black] [grey]

    perl extract_new_dom.pl dns53.pcap dom_white.txt dom_black.txt dom_grey.txt

dom_grey.txt 灰名单，暂不写入pac文件的域名列表，多为访问次数较少的长尾域名

检查生成的　dns53.pcap.dom.new.txt，人工决定加入dom_white/black/grey哪个文件。。。
