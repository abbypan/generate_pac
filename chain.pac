var default_proxy = 'SOCKS5 127.0.0.1:8080; DIRECT';
var chain_proxy = 'SOCKS5 127.0.0.1:8088; DIRECT';
var chain_list = [
"chatgpt.com",
"openai.com"
];


function FindProxyForURL(url, host) {
    if(! host) return direct;

    for (var i = 0; i < chain_list.length; i += 1) {
        var v = chain_list[i];
        var dotv = '.' + v;
        if ( dnsDomainIs(host, dotv) || dnsDomainIs(host, v)) {
            return chain_proxy;
        }
    }

    return default_proxy;
};
