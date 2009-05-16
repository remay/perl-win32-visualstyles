#!perl -w
use strict;
use warnings;

use 5.006;
use ExtUtils::MakeMaker;
use Config();

my %config = (
    NAME          => 'Win32::VisualStyles',
    VERSION_FROM  => 'VisualStyles.pm',
    ABSTRACT_FROM => 'VisualStyles.pm',
    AUTHOR        => 'Robert May <robertmay@cpan.org>',
    PL_FILES      => {'$(BASEEXT).manifest.PL' => '$(BASEEXT).manifest',
                      '$(BASEEXT).version.PL'  => '$(BASEEXT).version' },
    depend        => {'$(BASEEXT).res' => '$(BASEEXT).manifest $(BASEEXT).version', },
    OBJECT        => '$(BASEEXT)$(OBJ_EXT) $(BASEEXT).res',
    macro         => { RC => 'rc.exe',
                       RCFLAGS => '',
                     },
    clean         => { FILES => '$(BASEEXT).manifest $(BASEEXT).version', },
);

# if building using gcc (MinGW or cygwin) use windres
# as the resource compiler
if($Config::Config{cc} =~ /gcc/i) {
    $config{macro}->{RC} =      'windres';
    $config{macro}->{RCFLAGS} = '-O coff -o $*.res';
}

WriteMakefile(%config);

package MY;

# Add rule for .rc to .res conversion
sub postamble {
  return <<'__POSTAMBLE';

.rc.res:
	$(RC) $(RCFLAGS) $<

__POSTAMBLE
}
