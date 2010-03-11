package Data::Validator::Simple;
use strict;
use warnings;
our $VERSION = '0.01';
use Carp;
use Data::Validator::Simple::Checker;

sub new {
    my ( $class, %opt ) = @_;
    my $checker = Data::Validator::Simple::Checker->new;
    my $self = bless { data => $opt{data}, checker => $checker }, $class;
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
    eval { $result = $self->{checker}->$rule( $self->{data}, $params ) };
    Carp::croak("Can't load \"$rule\" rule\n") if $@;
    return $success if $success && $result;
    return $result;
}

1;

__END__

=head1 NAME

Data::Validator::Simple - Simple "single" data validator. Not only for form validator.

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
  print $result; # second_message

=head1 DESCRIPTION

Data::Validator::Simple is a data validator but not only for form validation.

=head1 VALIDATION RULES

=over 4

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
