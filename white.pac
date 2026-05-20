var direct = 'DIRECT';
var default_proxy = 'SOCKS5 127.0.0.1:8080; DIRECT';
var white_list = [
"cn",
"126.net",
"163.com",
"360buyimg.com",
"aliapp.org",
"alibaba.com",
"alicdn.com",
"alipay.com",
"alitrip.com",
"aliyun.com",
"baidu.com",
"baiducontent.com",
"baidupcs.com",
"baidustatic.com",
"bdimg.com",
"bdstatic.com",
"bilibili.com",
"dou.bz",
"douban.com",
"douban.fm",
"doubanio.com",
"etao.com",
"hao123.com",
"hdslb.com",
"jd.com",
"jiathis.com",
"jjwxc.net",
"kongfz.com",
"lecloud.com",
"letv.com",
"letvcloud.com",
"lofter.com",
"qihucdn.com",
"qq.com",
"qqmail.com",
"qzone.com",
"sinastorage.com",
"smzdm.com",
"soso.com",
"tanx.com",
"taobao.com",
"taobaocdn.com",
"tencent.com",
"tmall.com",
"upqzfile.com",
"upqzfilebk.com",
"weibo.com",
"weiyun.com",
"xmcdn.com",
"ykimg.com",
"zhihu.com",
"zhimg.com"
];

function FindProxyForURL(url, host) {
    if(! host) return direct;

    for (var i = 0; i < white_list.length; i += 1) {
        var v = white_list[i];
        var dotv = '.' + v;
        if ( dnsDomainIs(host, dotv) || dnsDomainIs(host, v)) {
            return direct;
        }
    }

    return default_proxy;
};
