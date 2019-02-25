#!/usr/bin/perl

use strict;
use warnings;

my $input = 'input';

open(my $fh, '<:encoding(UTF-8)', $input) or die $!;
my $firstLine = <$fh>;
$firstLine =~ s/\n//g;
my $headerFileName = $firstLine . '.h';
my $cFileName = $firstLine . '.c';
open(my $headerFile, '>', $headerFileName) or die $!;
open(my $cFile, '>', $cFileName) or die $!;
print $headerFile 'extern const char* ' . uc $firstLine . '_names[];' . "\n";
print $headerFile 'typedef enum {' . "\n";
print $cFile 'const char* NAME_names[] = {' . "\n";
while (my $row = <$fh>) {
    $row =~ s/\n//g;
    if (eof($fh)) {
        print $headerFile $row . "\n";
        print $cFile "\"" . $row . "\"\n";
    } else {
        print $headerFile $row . ",\n";
        print $cFile "\"" . $row . "\",\n";
    }
}
print $headerFile '} NAME;';
print $cFile '}';

## Close files
close $fh;
close $headerFile;
close $cFile;
