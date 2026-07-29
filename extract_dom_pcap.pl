#!/usr/bin/perl
use strict;
use warnings;

my ( $dom_pcap, $white, $black, $grey ) = @ARGV;
$dom_pcap ||= "dns53.pcap";
$white ||= 'dom_white.txt';
$black ||='dom_black.txt';
$grey ||='dom_grey.txt';

system( qq[tshark -r $dom_pcap -E 'separator=;' -T fields -e dns.qry.name |sort |uniq > $dom_pcap.dom.all.txt] );

my %wrote_dom = ( read_dom_hash( $white ) , read_dom_hash( $black ), read_dom_hash( $grey ) );

my %dom_raw = read_dom_hash( "$dom_pcap.dom.all.txt" );
open my $fh, '>', "$dom_pcap.dom.new.txt";
for my $dom ( keys( %dom_raw ) ) {
    next if ( $dom =~ /\.cn$/ );         #cn域名默认白名单
    my ( $dom2 )     = $dom =~ /^.*?([^.]+\.[^.]+)$/;
    next unless($dom2);
    my ( $dom3 ) = $dom =~ /^.*?([^.]+\.[^.]+\.[^.]+)$/;
    $dom3 ||= $dom2;

    next if ( exists $wrote_dom{$dom2} or exists $wrote_dom{$dom3} );

    my $ret_dom = $dom2 =~ /^(com|net|org)\./ ? $dom3 : $dom2;
    print $fh "$ret_dom\n";
    $wrote_dom{$ret_dom} = 1;
}
close $fh;

sub read_dom_hash {
  my ( $f ) = @_;
  open my $fh, '<', $f;
  my @dom = <$fh>;
  close $fh;
  chomp( @dom );
  my %dom = map { lc( $_ ) => 1 } @dom;
  return %dom;
}
