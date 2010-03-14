package Data::Validator::Simple::Checker;
use strict;
use warnings;
use Data::Validator::Simple::Types;

sub new {
    my ( $class, %opt ) = @_;
    my $self = bless {}, $class;
    $self->{type} = Data::Validator::Simple::Types->new( type => $opt{type} )
      if $opt{type};
    $self;
}

sub ASCII {
    my ( $self, $data ) = @_;
    return $data =~ /^[\x21-\x7E]+$/;
}

sub EQUAL_TO {
    my ( $self, $data, $params ) = @_;
    if( $data =~ /\d+/ && $params->[0] =~ /\d+/){
        return $data == $params->[0];
    }else{
        return $data eq $params->[0];
    }
}

sub LENGTH {
    my ( $self, $data, $params ) = @_;
    my $length = length $data;
    if( defined $params->[1] ){
        return $params->[0] <= $length && $length <= $params->[1];
    }else{
        return $length == $params->[0];
    }
}

sub BETWEEN {
    my ( $self, $data, $params ) = @_;
    $data = $self->{type} ? $self->{type}->to_number( $data ) : $data;
    my $start = $self->{type} ? $self->{type}->to_number($params->[0]) : $params->[0];
    my $end = $self->{type} ? $self->{type}->to_number($params->[1]) : $params->[1];
    return $data >= $start && $data <= $end;
}

sub GREATER_THAN {
    my ( $self, $data, $params ) = @_;
    $data = $self->{type} ? $self->{type}->to_number( $data ) : $data;
    $params->[0] = $self->{type}->to_number($params->[0]) if $self->{type};
    return $data > $params->[0];
}

sub LESS_THAN {
    my ( $self, $data, $params ) = @_;
    $data = $self->{type} ? $self->{type}->to_number( $data ) : $data;
    $params->[0] = $self->{type}->to_number($params->[0]) if $self->{type};
    return $data < $params->[0];
}

1;
