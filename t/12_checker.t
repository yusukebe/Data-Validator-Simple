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
    ok( $checker->LENGTH( 'Hello', [ 5 ] ), 'LENGTH: single true' );
    ok( $checker->LENGTH( 'Hello', [ 4, 6 ] ), 'LENGTH: between true' );
}

{
    ok( $checker->BETWEEN( 5, [ 4, 6 ] ), 'BETWEEN: true' );
    ok( !$checker->BETWEEN( 5, [ 6, 10 ] ), 'BETWEEN: false' );
}

{
    ok( $checker->GREATER_THAN( 5, [ 4 ] ), 'GREATER_THAN: true' );
    ok( $checker->LESS_THAN( 5, [ 6 ] ), 'LESS_THAN: true' );
}

{
    use utf8;
    ok( $checker->ASCII( 'abcd' ), 'ASCII: true' );
    ok( !$checker->ASCII( '日本語' ), 'ASCII: false' );
}

done_testing;
