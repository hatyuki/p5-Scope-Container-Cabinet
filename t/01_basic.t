use strict;
use warnings;
use t::Mock;
use Test::More;
use Scope::Container;

subtest out_scope => sub {
    my $hash = t::Mock->get('hash');
    is_deeply $hash, +{ foo => 'bar' };

    my $other = t::Mock->get('hash');
    is_deeply $other, +{ foo => 'bar' };
    isnt $other, $hash;
};

subtest in_scope => sub {
    my $guard = start_scope_container( );
    my $hash  = t::Mock->get('hash');
    is_deeply $hash, +{ foo => 'bar' };

    my $other = t::Mock->get('hash');
    is_deeply $other, +{ foo => 'bar' };
    is $other, $hash;
};

done_testing;
