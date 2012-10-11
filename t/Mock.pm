package t::Mock;
use strict;
use warnings;
use Scope::Container::Cabinet -base;

register hash => sub {
    return +{ foo => 'bar' };
};

1;
