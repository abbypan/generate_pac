# generate_pac
自动更新pac代理文件

# 安装　

以debian环境为例

    apt-get install tcpdump tshark

# generate_pac_white.pl

示例

    perl generate_pac_white.pl [pac_fname] [default_proxy] [white_dom_fname]

    perl generate_pac_white.pl local.pac 127.0.0.1:8080 dom_white.txt

pac_fname 生成的目标pac文件

默认走default proxy，在white_dom_fname里的走DIRECT

# generate_pac_chain.pl

    perl generate_pac_chain.pl [pac_fname] [default_proxy] [chain_proxy] [chain_dom_fname]

默认走default proxy，在chain_dom_fname里的走chain proxy

# extract_dom_pcap.pl 

域名抓包

    sudo tcpdump port 53 -s0 -w dns53.pcap 

示例

    perl extract_dom_pcap.pl [dom_pcap] [white] [black] [grey]

    perl extract_dom_pcap.pl dns53.pcap dom_white.txt dom_black.txt dom_grey.txt

dom_grey.txt 灰名单，暂不写入pac文件的域名列表，多为访问次数较少的长尾域名

检查生成的　dns53.pcap.dom.new.txt，人工决定加入dom_white/black/grey哪个文件。。。

# generate_dnsmasq_conf.pl 

dnsmasq相关配置参考：[dnsmasq_dnscrypt_configure](https://github.com/abbypan/dnsmasq_dnscrypt_configure)

默认读入当前目录下的 dom_white.txt, dom_black.txt，生成dnsmasq的域名配置文件

    perl generate_dnsmasq_conf [white_resolver] [black_resolver]

    perl generate_dnsmasq_conf.pl 114.114.114.114 127.0.0.1:53330

生成 dom_white.txt.conf, dom_black.txt.conf，并复制到/etc/dnsmasq.d目录下，重启dnsmasq
