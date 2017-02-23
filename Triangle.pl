#!/usr/bin/env perl
use strict;
use warnings;
use Shape::Triangle;

if ((scalar(@ARGV) < 3)) {
  print "Please specify all arguments\n";
  print "\n";
  print "1. Side 1 \n";
  print "2. Side 2 \n";
  print "2. Side 3 \n";

  exit 20;
}

my $triangle = Shape::Triangle->new( {side_1 => $ARGV[0],  side_2 => $ARGV[1],  side_3 => $ARGV[2]} );

print "\n Triangle with sides " . $ARGV[0] . " " . $ARGV[1] . " " . $ARGV[2] . " is " . $triangle->triangle_type() . " \n";