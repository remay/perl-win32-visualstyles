#!perl -w
use strict;
use warnings;

# XXX: $arch is currently unused.  So long as is turns out
# that not specifying a processorArchitecture (or using "*")
# works, then this file can be removed and replaced with a
# static VisualStyles.manifest
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
		version="00.00.02.00"
        name="Perl.Win32.VisualStyles"
        type="win32" />
    <description>Perl extension for enabling Visual (aka XP) Styles.</description>
    <dependency>
        <dependentAssembly>
            <assemblyIdentity
                 type="win32"
                 name="Microsoft.Windows.Common-Controls"
                 version="6.0.0.0"
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
