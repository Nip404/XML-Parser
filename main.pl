use strict;
use warnings;

use testlibs::XMLParser;
use feature "say";

my $filename = "sample.xml";
my $expr = "/playlist/movie";
my @args = (
    "./title",
    "./director",
);

my $parser = new XMLParser("file", $filename);
say $parser->parse($expr, @args);
