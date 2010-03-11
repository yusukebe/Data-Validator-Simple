use strict;
use Test::More;
use Data::Validator::Simple;
use utf8;

my $form = Data::Validator::Simple->form;
is( ref $form,'Data::Validator::Simple::Form', 'Make form instance' );

eval { use CGI; };

unless ($@) {
    my $q = CGI->new;
    $q->param( id   => 'abcde' );
    $q->param( name => 'ユーザー名' );
    my %params = $q->Vars;
    my $results = $form->check(
        \%params,
        {
            id => [ 'ASCII', [ 'LENGTH', 4, 10 ] ],
            name => [ 'LENGTH', 4, 20  ]
        }
    );
    is( ref $results, 'HASH' );
    ok( $results->{id} , 'Param id is valid' );
    ok( $results->{name} , 'Param name is valid' );
}
else {
    diag "Skip form test unless CGI.pm";
}

done_testing;
