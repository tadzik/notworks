use strict;
use warnings;
use feature 'say';
use Data::Dumper;

my $iter = -1;
my @nws;

while(<>) {
	s/^\s*//;
	if (m/^Cell /) {
		$nws[++$iter] = {};
		($nws[$iter]->{addr}) = m/Address: (.+)$/;
	}
	($nws[$iter]->{channel}) = $1 if m/^Channel:(\d+)$/;
	if (m/Quality=(\d+)\/(\d+)/) {
		$nws[$iter]->{quality} = int($1 / $2 * 100 + .5);
	}
	($nws[$iter]->{encckey}) = $1 if m/^Encryption key:(.+)$/;
	($nws[$iter]->{essid}) = $1 if m/^ESSID:"([^"]+)"$/;
	($nws[$iter]->{wpaver}) = $1 if m/^IE: WPA Version (\d)$/;
}

@nws = reverse sort {$a->{quality} <=> $b->{quality}} @nws;

print Dumper @nws;
