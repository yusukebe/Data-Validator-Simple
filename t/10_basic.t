use strict;
use Test::More;

use_ok('Data::Validator::Simple');

# simple usecase
{
    my $data = Data::Validator::Simple->new( data => 5 );
    ok( $data, 'Make instance' );
    my $result = $data->check( [ 'BETWEEN', 4, 50 ] );
    ok( $result, 'Result is "valid"' );
    $result = $data->check( 'ASCII' );
    ok( $result, 'ASCII rule' );
    eval { $data->check(['RULE_NOT_FOUND']) };
    ok( $@, 'Rule not found in chcker' );
}

# pass 2 args
{
    my $data = Data::Validator::Simple->new( data => 5 );
    my $result = $data->check( [ 'EQUAL_TO', 4 ] , [ 'EQUAL_TO', 6 ] );
    ok( !$result, 'Result is "invalid"' );
}

done_testing;
