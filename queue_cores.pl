#!/usr/bin/perl

use XML::Smart;
my ($xml,$qstat);

$qstat=`/cm/shared/apps/sge/2011.11p1/bin/linux-x64/qstat -u \* -ext -xml -s r -F`;
$xml = XML::Smart->new($qstat);

my @now = localtime();

my $timeStamp = sprintf("%04d%02d%02d%02d%02d%02d",
	$now[5]+1900, $now[4]+1, $now[3],
	$now[2], $now[1], $now[0]);

print "$timeStamp\n";

for ($xml->{job_info}{queue_info}{'Queue-List'}('@')) {
	print $_->{slots_used},"\n";
}

my $fileName = "cores_used_$timeStamp.txt";
