var direct = 'DIRECT';
var http_proxy = 'SOCKS5 127.0.0.1:8888; DIRECT';
var white_list = [
"cn",
"126.net",
"163.com",
"360buyimg.com",
"51nb.com",
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
"changba.com",
"dou.bz",
"douban.com",
"douban.fm",
"doubanio.com",
"etao.com",
"hao123.com",
"hdslb.com",
"ietf.org",
"jd.com",
"jiathis.com",
"jjwxc.net",
"kongfz.com",
"lecloud.com",
"letv.com",
"letvcloud.com",
"lofter.com",
"miaopai.com",
"newsmth.net",
"ourdvsss.com",
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
"xiami.com",
"xiami.net",
"xmcdn.com",
"ykimg.com",
"youdao.com",
"zhaopin.com",
"zhihu.com",
"zhimg.com"
];

var black_list = [
"adblockplus.org",
"firefox.com",
"getdropbox.com",
"github.com",
"github.io",
"google-analytics.com",
"google.com",
"googleadservices.com",
"googleapis.com",
"googletagmanager.com",
"googleusercontent.com",
"gstatic.com",
"gtimg.com",
"mozilla.com",
"oracle.com",
"youtube.com"
];

function FindProxyForURL(url, host) {
    if(! host) return direct;

    for (var i = 0; i < black_list.length; i += 1) {
        var v = black_list[i];
        var dotv = '.' + v;
        if ( dnsDomainIs(host, dotv) || dnsDomainIs(host, v)) {
            return http_proxy;
        }
    }

    for (var i = 0; i < white_list.length; i += 1) {
        var v = white_list[i];
        var dotv = '.' + v;
        if ( dnsDomainIs(host, dotv) || dnsDomainIs(host, v)) {
            return direct;
        }
    }

    return http_proxy;
};
