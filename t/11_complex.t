use strict;
use Test::More;
use Data::Validator::Simple;

# complex usecase
{
    my $data = Data::Validator::Simple->new( data => 5 );
    my $result = $data->check(
        {
            rule    => [ 'EQUAL_TO', 6 ],
            success => 'fist_message',
        },
        {
            rule    => [ 'EQUAL_TO', 5 ],
            success => 'second_message',
        }
    );
    is( $result, 'second_message', 'Complex pattern is ok' );
}
done_testing;
