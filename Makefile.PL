#############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile for Wx::ActiveX
## Author:      Graciliano M. P.
## Modified by:
## SVN-ID:      $Id$
## Copyright:   (c) 2002 - 2007 Graciliano M. P. and Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use Wx::build::MakeMaker ;
use Config ;

my $libs = '' ;
if( $Config{cc} =~ /^cl/i ) { $libs = 'msvcprt.lib' ;}

wxWriteMakefile( NAME           => 'Wx::ActiveX',
                 ABSTRACT_FROM  => 'lib/Wx/ActiveX.pm',
                 VERSION_FROM   => 'lib/Wx/ActiveX.pm',
                 AUTHOR		    => 'Graciliano M. P. <gm@virtuasites.com.br>',
                 LIBS           => $libs ,
                 WX_CORE_LIB	=> 'core base',
                 NO_META 		=> 1,
                 WX_OVERLOAD	=> {	header  => 'cpp/ovl_const.h',
                                        source  => 'cpp/ovl_const.cpp',
                                    },
                 PREREQ_PM	=> { Wx   => '0.57',
                                        },
               );

# local variables:
# mode: cperl
# end:
