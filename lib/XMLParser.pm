package XMLParser;

use XML::LibXML;
use feature "say";

sub new {
    my $class = shift;
    my $self = {
        type => shift,
        data => shift,
    };

    bless $self, $class;

    if ($self->{type} eq "file") {
        $self->{dom} = XML::LibXML->load_xml(location => $self->{data});
    } elsif ($self->{type} eq "string") {
        $self->{dom} = XML::LibXML->load_xml(string => $self->{data});
    } else {
        die "Invalid data type";
    };
    
    return $self;
};

sub parse {
    my $self = shift;
    my $expr = shift;
    my @args = @_;

    if (!@args) {
        return stdparse($self->{dom}, $expr);
    } else {
        return parsemany($self->{dom}, $expr, @args);
    };
};

sub stdparse {
    my $dom = shift;
    my $expr = shift;

    return map($_->to_literal(), $dom->findnodes($expr));
};

sub parsemany {
    my $dom = shift;
    my ($expr, @args) = @_;

    return map {
        my $node = $_;
        map {$node->findvalue($_)} @args;
    } $dom->findnodes($expr);
};

1;
