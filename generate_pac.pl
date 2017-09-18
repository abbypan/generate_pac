#!/usr/bin/perl
use strict;
use warnings;

my ($pac_fname, $socks_ip_port, $white, $black) = @ARGV;
$pac_fname ||= 'local.pac';
$socks_ip_port ||= '127.0.0.1:8888';
$white ||= 'dom_white.txt';
$black ||= 'dom_black.txt';

generate_pac($pac_fname, $socks_ip_port, $white, $black);

sub generate_pac {
    my ($pac_fname, $socks_ip_port, $white, $black) = @_;
    my $white_info = read_dom_list($white);
    my $black_info = read_dom_list($black);

    open my $fh, '>', $pac_fname;
    print $fh <<__DATA__;
var direct = 'DIRECT';
var http_proxy = 'SOCKS5 $socks_ip_port; DIRECT';
var white_list = [
$white_info
];

var black_list = [
$black_info
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
