#############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL for wxActiveX
## Author:      Graciliano M. P.
## Modified by:
## Created:     23/ 5/2002
## RCS-ID:      
## Copyright:   (c) 2002 Graciliano M. P.
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use Wx::build::MakeMaker ;
use Config ;

my $libs = '' ;
if( $Config{cc} =~ /^cl/i ) { $libs = 'msvcprt.lib' ;}

wxWriteMakefile( NAME         => 'Wx::ActiveX',
                 VERSION_FROM => 'lib/Wx/ActiveX.pm',
                 LIBS         => $libs ,
               );

# local variables:
# mode: cperl
# end:
