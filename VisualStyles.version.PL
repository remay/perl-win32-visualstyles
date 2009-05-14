#!perl -w
use strict;
use warnings;
use ExtUtils::MakeMaker;

my $version = MM->parse_version('VisualStyles.pm');
$version .= "_00" unless $version =~ m/_/;
$version = sprintf("%02d,%02d,%02d,00", $version =~ m/^(.*)\.([^_]*)_?(.*)$/);

my $file = shift;
my $fh;
if($file) {
    open($fh, ">", $file) or die "Can't open '$file' for writing: $!";
    select $fh;
}

print <<"__EOT";
#include "Winver.h"

1 VERSIONINFO
FILEVERSION    $version
PRODUCTVERSION $version
FILEOS         VOS__WINDOWS32
FILETYPE       VFT_DLL
{
  BLOCK "StringFileInfo"
  {
    BLOCK "040904E4"
    {
      VALUE "Comments"         , "Win32::VisualStyles"
      VALUE "CompanyName"      , "Robert May"
      VALUE "FileDescription"  , "Win32::VisualStyles - A Perl Extension to enable visual styles."
      VALUE "FileVersion"      , "$version"
      VALUE "InternalName"     , "VisualStyles.dll"
      VALUE "LegalCopyright"   , "Copyright © Robert May 2009"
      VALUE "LegalTrademarks"  , "GNU and Artistic licences"
      VALUE "OriginalFilename" , "VisualStyles.dll"
      VALUE "ProductName"      , "Win32::VisualStyles perl extension"
      VALUE "ProductVersion"   , "$version"
    }
  }

  BLOCK "VarFileInfo"
  {
    VALUE "Translation", 0x0409, 0x04E4
  }
}
__EOT

if($fh) {
    close($fh) or die "Couldn't write '$file': $!";
}
exit(0);
