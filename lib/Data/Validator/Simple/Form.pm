package Data::Validator::Simple::Form;
use strict;
use warnings;
use Data::Validator::Simple;

sub new {
    my ( $class, %opt ) = @_;
    my $self = bless {}, $class;
    $self;
}

sub check {
    my ( $self, $params, $dataset ) = @_;
    my $results;
    for my $key ( keys %$dataset ){
        if ( defined $params->{$key} ){
            my $result = $self->check_single( $params->{$key}, $dataset->{$key} );
            $results->{$key} = $result;
        }
    }
    return $results;
}

sub check_single {
    my ( $self, $data, $conditions ) = @_;
    my $validator = Data::Validator::Simple->new( data => $data );
    my $result = $validator->check( [@$conditions] );
    return $result;
}

1;
