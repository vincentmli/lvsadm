#!/usr/bin/perl

use strict;
use warnings;
use Config::Ldirectord;
use Data::Dumper;


my $cfg = new Config::Ldirectord(
	filename=>'./ldirectord.cf',
	syntax=>'ini'
);
#print Dumper($cfg);

$cfg->param("10-1-72-169:80.receive", "It works oh yes");
$cfg->param("default.autoreload", "no");
$cfg->param("vip.eth0:1", "192.168.1.111");
$cfg->param("vip.eth0:4", "192.168.1.112");


$cfg->param("192-168-1-169:80.virtual", "192.168.1.160:80");
$cfg->param("192-168-1-169:80.checktype", "connect");
$cfg->param("192-168-1-169:80.protocol", "tcp");
$cfg->param("192-168-1-169:80.real", "192.168.3.2:80 masq = 192.168.3.3:80 masq = 192.168.3.4:80 masq = 192.168.3.4:80 masq = 192.168.3.8:80 masq");

$cfg->write();

#print Dumper($cfg);

