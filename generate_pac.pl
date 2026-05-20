#!/usr/bin/perl
use strict;
use warnings;

my ($pac_fname, $default_proxy, $white) = @ARGV;
$pac_fname ||= 'white.pac';
$default_proxy ||= '127.0.0.1:8080';
$white ||= 'dom_white.txt';

generate_pac($pac_fname, $default_proxy, $white);

sub generate_pac {
    my ($pac_fname, $default_proxy, $white) = @_;
    my $white_info = read_dom_list($white);

    open my $fh, '>', $pac_fname;
    print $fh <<__DATA__;
var direct = 'DIRECT';
var default_proxy = 'SOCKS5 $default_proxy; DIRECT';
var white_list = [
$white_info
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
