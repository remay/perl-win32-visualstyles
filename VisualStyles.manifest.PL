#!perl -w
use strict;
use warnings;

my $arch = $ENV{PROCESSOR_ARCHITECTURE};
 
my $file = shift;
my $fh;
if($file) {
    open(my $fh, ">", $file) or die "Can't open '$file' for writing: $!";
    select $fh;
}
 
print <<"EOT";
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<assembly xmlns="urn:schemas-microsoft-com:asm.v1" manifestVersion="1.0">
	<assemblyIdentity
		version="0.0.0.0"
		processorArchitecture="$arch"
        name="Perl.Win32.VisualStyles"
        type="Win32" />
    <description>Perl extension for enabling Visual (aka XP) Styles.</description>
    <dependency>
        <dependentAssembly>
            <assemblyIdentity
                 type="Win32"
                 name="Microsoft.Windows.Common-Controls"
                 version="6.0.0.0"
                 processorArchitecture="$arch"
                 publicKeyToken="6595b64144ccf1df"
                 language="*" />
        </dependentAssembly>
    </dependency>
</assembly>
EOT
 
if($fh) {
    close($fh) or die "Couldn't write '$file': $!";
}
exit(0);
