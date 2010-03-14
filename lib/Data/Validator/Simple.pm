package Data::Validator::Simple;
use strict;
use warnings;
our $VERSION = '0.01_02';
use Carp ();
use Data::Validator::Simple::Checker;

sub new {
    my ( $class, %opt ) = @_;
    my $self    = bless {
        data            => $opt{data},
        default_message => $opt{failed},
    }, $class;
    my $checker = Data::Validator::Simple::Checker->new( type => $opt{as} );
    $self->{checker} = $checker;
    $self;
}

sub check {
    my $self = shift;
    my @conditions = @_;
    for ( @conditions ){
        my $result = $self->_validate( $_ );
        return $result if $result;
    }
    return;
}

sub form {
    require Data::Validator::Simple::Form;
    return Data::Validator::Simple::Form->new;
}

sub _validate {
    my ( $self, $condition ) = @_;
    my ($rule, $params, $success);
    if ( ref $condition eq 'HASH' ){
        $rule = shift @{$condition->{rule}};
        $params = $condition->{rule};
        $success = $condition->{success};
    }else{
        if( ref $condition eq 'ARRAY' ){
            $rule = shift @$condition;
            $params = $condition;
        }else{
            $rule = $condition;
        }
    }
    my $result;
    eval { $result = $self->{checker}->$rule( $self->{data}, $params ); };
    Carp::croak("Can't load \"$rule\" rule\n") if $@;
    return $success if $success && $result;
    return $self->{default_message} if defined $self->{default_message};
    return $result;
}

1;

__END__

=head1 NAME

Data::Validator::Simple - Simple data validator. Not only for form validator.

=head1 SYNOPSIS

  use Data::Validator::Simple;

  my $data = Data::Validator::Simple->new( data => 5 );
  my $result = $data->check( ['BETWEEN', 4, 10 ] );
  if( $result ){
      print "valid";
  }else{
      print "error";
  }

complex pattern

  my $data = Data::Validator::Simple->new( data => 5 , failed => 'failed message' );
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
  print $result; # second_message

if want to use as form validator

  my $q = CGI->new;
  $q->param( id   => 'login_id' );
  $q->param( name => 'user_name' );
  my %params = $q->Vars;

  my $form = Data::Validator::Simple->form;
  my $results = $form->check(
      \%params,
      {
          id => [ 'ASCII', [ 'LENGTH', 4, 10 ] ],
          name => [ 'LENGTH', 4, 20  ]
      }
   );
  if( $results->{id} && $results->{name} ){
      print "valid";
  }

=head1 DESCRIPTION

Data::Validator::Simple is a data validator but not only for form validation.

=head1 VALIDATION RULES

=over 4

=item ASCII

  my $data = Data::Validator::Simple->new( data => 'abcde' );
  $data->check( 'ASCII' );

=item EQUAL_TO

  my $data = Data::Validator::Simple->new( data => 5 );
  $data->check( [ 'EQUAL_TO', 5 ] );

  $data = Data::Validator::Simple->new( data => 'Hello' );
  $data->check( [ 'EQUAL_TO', 'Hello' ] );

=item LENGTH

  my $data = Data::Validator::Simple->new( data => 'Hello' );
  $data->check( [ 'LENGTH', 5 ] );

  $data = Data::Validator::Simple->new( data => 'Hello' );
  $data->check( [ 'LENGTH', 4, 6 ] );

=item BETWEEN

  my $data = Data::Validator::Simple->new( data => 5 );
  $data->check( [ 'BETWEEN', 2, 10 ] );

  my $data = Data::Validator::Simple->new( data => [ 'year', 'month', 'date' ], as => 'DATE' );
  $data->check( [ 'BETWEEN', [ 'year', 'month', 'date' ] , [ 'year', 'month', 'date' ] ] );

=item GREATER_THAN

  my $data = Data::Validator::Simple->new( data => 5 );
  $data->check( [ 'GREATER_THAN', 4 ] );

=item LESS_THAN

  my $data = Data::Validator::Simple->new( data => 5 );
  $data->check( [ 'LESS_THAN', 6 ] );

=back

=head1 AUTHOR

Yusuke Wada E<lt>yusuke at kamawada.comE<gt>

=head1 SEE ALSO

L<FormValidator::Simple>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
