use strict;
use warnings;
use t::Mock -export => 'get_model';
use Test::More;
use Scope::Container;

my $guard = start_scope_container( );
my $hash  = get_model('hash');
is_deeply $hash, +{ foo => 'bar' };

my $other = get_model('hash');
is_deeply $other, +{ foo => 'bar' };
is $other, $hash;

done_testing;
