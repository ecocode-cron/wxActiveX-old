#############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile for Wx::ActiveX
## Author:      Graciliano M. P.
## SVN-ID:      $Id$
## Copyright:   (c) 2002 - 2008 Graciliano M. P., Mattia Barbon, Mark Dootson
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use Wx::build::MakeMaker ;
use Config ;
if(!$ENV{BUILD_WXACTIVEX_ANYWAY}) {
    die 'Interface is currently broken. Please use PPM from http://www.wxperl.co.uk until next CPAN release';
}

my $libs = '' ;
if( $Config{cc} =~ /^cl/i ) { $libs = 'msvcprt.lib' ;}

wxWriteMakefile( NAME           => 'Wx::ActiveX',
                 ABSTRACT_FROM  => 'lib/Wx/ActiveX.pm',
                 VERSION_FROM   => 'lib/Wx/ActiveX.pm',
                 AUTHOR		    => 'Graciliano M. P. <gm@virtuasites.com.br>',
                 LIBS           => $libs ,
                 EXE_FILES     => [ qw(script/wxactivex_browser) ],
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
