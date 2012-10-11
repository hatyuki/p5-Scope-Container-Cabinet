package Scope::Container::Cabinet;
use strict;
use warnings;
use Carp ( );
use Scope::Container;

our $VERSION = '0.01';
my  $CODES;

sub import
{
    my ($class, $type, $export) = @_;
    my $caller = caller;

    if ($type && $type eq '-base') {
        my %exports = (
            register => \&__register,
            model    => \&__model,
        );
        
        {
            no strict 'refs';
            push @{"${caller}::ISA"}, $class;
            *{"${caller}::$_"} = $exports{$_} for keys %exports;
        }
    }
    elsif ($type && $type eq '-export') {
        no strict 'refs';
        *{"${caller}::${export}"} = \&__model;
    }
}

sub __register
{
    my ($key, $code) = @_;
    Carp::croak("'$key' is not callable") if ref $code ne 'CODE';

    __codes($key, $code);
}

sub __model
{
    my $key = shift;

    if ( in_scope_container( ) && (my $model = scope_container($key)) ) {
        return $model;
    }
    elsif (my $code = __codes($key)) {
        my $model = $code->( );
        scope_container($key, $model) if in_scope_container( );
        return $model;
    }
    else {
        Carp::croak("'$key' is not registered");
    }
}

sub __codes
{
    # my ($key, $val) = @_;
    if (scalar @_ == 2) {
        $CODES->{$_[0]} = $_[1];
    }

    return $CODES->{$_[0]};
}

sub get { __model($_[1]) }

1;
__END__

=head1 NAME

Scope::Container::Cabinet -

=head1 SYNOPSIS

  use Scope::Container::Cabinet;

=head1 DESCRIPTION

Scope::Container::Cabinet is

=head1 AUTHOR

hatyuki E<lt>hatyuki29 {at} gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
