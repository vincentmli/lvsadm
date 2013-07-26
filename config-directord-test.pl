#!/usr/bin/perl

use strict;
use warnings;
use Config::Ldirectord;
use Data::Dumper;


my $cfg = new Config::Ldirectord(
	filename=>'./ldirectord.cf',
	syntax=>'ini'
);
print Dumper($cfg);

$cfg->param("10-1-72-169:80.receive", "It works");
$cfg->param("default.autoreload", "yes");
$cfg->write();

print Dumper($cfg);

