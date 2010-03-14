package Data::Validator::Simple::Types;
use strict;
use warnings;

sub new {
    my ( $class, %opt ) = @_;
    my $self = bless { type => uc $opt{type} || 'STRING' }, $class;
    $self;
}

sub to_number {
    my ( $self, $args ) = @_;
    if( ref $args eq 'ARRAY' && $self->{type} eq 'DATE' ){
        my ( $y, $m, $d ) = @$args;
        my $number = sprintf "%04d%02d%02d", $y, $m, $d;
        return $number;
    }
    return $args; #XXX not implemented yet.
}

1;
