use strict;
use Test::More;
use Data::Validator::Simple::Checker;

use_ok('Data::Validator::Simple::Checker');
my $checker = Data::Validator::Simple::Checker->new;
ok( $checker, 'Make instance');

{
    ok( $checker->EQUAL_TO( 5, [ 5 ] ), 'EQUAL_TO: number true' );
    ok( !$checker->EQUAL_TO( 5, [ 4 ] ), 'EQUAL_TO: number false' );
    ok( $checker->EQUAL_TO( 'Hello', [ 'Hello' ] ), 'EQUAL_TO: string true' );
    ok( !$checker->EQUAL_TO( 'Hello', [ 'Hell' ] ), 'EQUAL_TO: string false' );
}

{
    ok( $checker->BETWEEN( 5, [ 4, 6 ] ), 'BETWEEN: true' );
    ok( !$checker->BETWEEN( 5, [ 6, 10 ] ), 'BETWEEN: false' );
}

done_testing;
