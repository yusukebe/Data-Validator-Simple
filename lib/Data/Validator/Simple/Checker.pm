package Data::Validator::Simple::Checker;
use strict;
use warnings;

sub new {
    my ( $class, %opt ) = @_;
    my $self = bless {}, $class;
    $self;
}

sub EQUAL_TO {
    my ( $self, $data, $params ) = @_;
    return $data == $params->[0];
}

sub BETWEEN {
    my ( $self, $data, $params ) = @_;
    my $start = $params->[0];
    my $end = $params->[1];
    return $data >= $start && $data <= $end;
}

1;
