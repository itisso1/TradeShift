#!/usr/bin/env perl
use strict;
use warnings;
use FindBin qw ($Bin);
use lib "$Bin/..";
use Data::Dumper;
use Test::More tests => 5;
use Test::Exception;

BEGIN {
    use_ok('Triangle');
}

subtest 'Create a new invalid triangle object, no arguments' => sub 
{
  throws_ok ( sub { Shape::Triangle->new( ); }, qr/new - No config/ );
};

subtest 'Create a new valid triangle object, invalid arguments' => sub 
{
  plan tests => 3;
  throws_ok ( sub { Shape::Triangle->new( {side_1 => '', side_2 => '', side_3 => '' } ); }, qr/new - no\/not all sides passed/ );
  throws_ok ( sub { Shape::Triangle->new( {side_1 => 1,  side_2 => '', side_3 => '' } ); }, qr/new - no\/not all sides passed/ );
  throws_ok ( sub { Shape::Triangle->new( {side_1 => 1,  side_2 => 2,  side_3 => '' } ); }, qr/new - no\/not all sides passed/ );
};

subtest 'Create a new valid triangle object with arguments and validate them' => sub 
{
  plan tests => 4;
  my $tri_obj = undef;
  ok ( $tri_obj = Shape::Triangle->new( {side_1 => 1, side_2 => 2, side_3 => -1 }), "Triangle object created" );
  is ( $tri_obj->_validate(), 0, "Invalid input - negative side" );
  
  $tri_obj = Shape::Triangle->new( {side_1 => '!',  side_2 => '@',  side_3 => '#'} );
  is ( $tri_obj->_validate(), 0, "Invalid input - junk input" );
  
  $tri_obj = Shape::Triangle->new( {side_1 => 1,  side_2 => 2,  side_3 => 1} );
  is ( $tri_obj->_validate(), 1, "All sides valid" );
};

subtest 'Create a new valid triangle object with arguments validate and if valid return type of triangle' => sub 
{
  plan tests => 7;
  my $tri_obj = undef;
  ok ( $tri_obj = Shape::Triangle->new( {side_1 => 1, side_2 => 1, side_3 => -1 }), "Triangle object created" );
  is ( $tri_obj->triangle_type(), "Invalid side(s): 1 1 -1", "Invalid side - negative side" );
  
  $tri_obj = Shape::Triangle->new( {side_1 => 'a',  side_2 => 1,  side_3 => 1} );
  is ( $tri_obj->triangle_type(), "Invalid side(s): a 1 1", "Invalid side - char instead of digit" );

  $tri_obj = Shape::Triangle->new( {side_1 => 1,  side_2 => 1,  side_3 => 1} );
  is ( $tri_obj->triangle_type(), "equilateral", "Equilateral triangle" );
  
  $tri_obj = Shape::Triangle->new( {side_1 => 1,  side_2 => 2,  side_3 => 1} );
  is ( $tri_obj->triangle_type(), "isosceles", "Isosceles triangle" );
  
  $tri_obj = Shape::Triangle->new( {side_1 => 1,  side_2 => 2,  side_3 => 3} );
  is ( $tri_obj->triangle_type(), "scalene", "Scalene triangle" );
  
  $tri_obj = Shape::Triangle->new( {side_1 => 1.25,  side_2 => 2.367,  side_3 => 1.25} );
  is ( $tri_obj->triangle_type(), "isosceles", "isosceles triangle - decimal sides" );
};

done_testing();
