use strict;
use Test::More;

use_ok('Data::Validator::Simple::Types');

my $data_type = Data::Validator::Simple::Types->new( type => 'DATE' );
ok( $data_type, 'Make instance' );
my $number = $data_type->to_number( [ 2010, 3, 15 ] );
is( $number, 20100315, 'Success to_number method' );

done_testing;
