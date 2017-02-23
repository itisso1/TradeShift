package Shape::Triangle;

use v5.12;
use strict;
use Carp;

sub new {
    my $class  = shift;
    my $config = shift // croak('new - No config');

    croak('new - no/not all sides passed') unless ( $config->{side_1} && $config->{side_2} && $config->{side_3} );
      
    my $self = bless { config => $config }, $class;
  
    return $self;
}

sub triangle_type {
    my $self = shift // croak ('get_triangle_type - no self');
    
    given ( $self->_validate() ) {
        when ( 0 ) { return "Invalid side(s): " . $self->_side_1() . " " . $self->_side_2() . " " . $self->_side_3(); }
        when ( 1 ) { return $self->_get_triangle_type() };
        default { return "Invalid input"; } 
    }
}

sub _validate {
    my $self = shift // croak ('_validate - no self');
    
    return 0 if ( $self->_side_1() !~ /\d/ || $self->_side_2() !~ /\d/ || $self->_side_3() !~ /\d/ );

    return 0 if ( $self->_side_1() < 0 || $self->_side_2() < 0 || $self->_side_3() < 0 );
    
    return 1;
}

sub _get_triangle_type {
    my $self = shift // croak ('_get_triangle_type - no self');
    
    return "equilateral" if ( ($self->_side_1() == $self->_side_2()) && ($self->_side_1() == $self->_side_3()) );
    return "scalene"     if ( ($self->_side_1() != $self->_side_2()) && ($self->_side_1() != $self->_side_3()) );
    return "isosceles";
}

sub _side_1 {
    my $self = shift // croak ('_side_1 - no self');
    
    return $self->{config}->{side_1};
}

sub _side_2 {
    my $self = shift // croak ('_side_2 - no self');
    
    return $self->{config}->{side_2};
}

sub _side_3 {
    my $self = shift // croak ('_side_3 - no self');
    
    return $self->{config}->{side_3};
}

1;
