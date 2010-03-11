use inc::Module::Install;
name 'Data-Validator-Simple';
all_from 'lib/Data/Validator/Simple.pm';

requires 'Carp';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
