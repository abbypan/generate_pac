#!/usr/bin/perl
use strict;
use warnings;

my ($pac_fname, $proxy_port, $chain_proxy_port, $chain) = @ARGV;
$pac_fname ||= 'chain.pac';
$proxy_port ||= '127.0.0.1:8080';
$chain_proxy_port ||= '127.0.0.1:8088';
$chain ||= 'dom_chain.txt';

generate_chain_pac($pac_fname, $proxy_port, $chain_proxy_port, $chain);

sub generate_chain_pac {
    my ($pac_fname, $proxy_port, $chain_proxy_port, $chain) = @_;
    my $chain_info = read_dom_list($chain);

    open my $fh, '>', $pac_fname;
    print $fh <<__DATA__;
var default_proxy = 'SOCKS5 $proxy_port; DIRECT';
var chain_proxy = 'SOCKS5 $chain_proxy_port; DIRECT';
var chain_list = [
$chain_info
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
__DATA__
    close $fh;

    return $pac_fname;
}

sub read_dom_list {
        my ($f) = @_;

    open my $fh, '<', $f;
    my @dom_list = <$fh>;
    close $fh;
    chomp(@dom_list);

    my $dom_res = join(",\n", map { qq["$_"] } @dom_list);
    return $dom_res;
}
