use inc::Module::Install;
license  'perl';
name     'Scope-Container-Cabinet';
all_from 'lib/Scope/Container/Cabinet.pm';

requires 'Scope::Container';

tests 't/*.t';

test_requires 'Test::More';
auto_set_repository;

WriteAll;
