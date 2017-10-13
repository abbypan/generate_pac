#!/usr/bin/perl

my ($white_resolver, $black_resolver) = @ARGV;

my $white_conf = generate_dnsmasq_conf('dom_white.txt', $white_resolver);
system(qq[sudo cp $white_conf /etc/dnsmasq.d/]);

my $black_conf = generate_dnsmasq_conf('dom_black.txt', $black_resolver);
system(qq[sudo cp $black_conf /etc/dnsmasq.d/]);

system(qq[sudo killall dnsmasq]);
system(qq[sudo dnsmasq]);

sub generate_dnsmasq_conf {
    my ($dom_f, $resolver) = @_;
    my $dst_f = "$dom_f.conf";

    $resolver=~s/:/#/;
    system(qq[cat $dom_f | sed -e 's#^#server=/#;s|\$|/$resolver|' > $dst_f]);
    return $dst_f;
}
