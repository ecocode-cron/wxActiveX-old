#############################################################################
## Name:        lib/Wx/ActiveX/Event.pm
## Purpose:     Wx::ActiveX events.
## Author:      Graciliano M. P.
## Modified by:
## Created:     01/09/2003
## SVN-ID:      $Id$
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::ActiveX::Event;
use strict;
use Wx;
require Wx::Event;
use base qw( Exporter );

our $VERSION = '0.06';

# VERSION 0.06 = events moved to Wx::Event - in Wx::ActiveX.
# this module now here only to support existing code.

our ( @EXPORT_OK, %EXPORT_TAGS );

my @exportconstants = qw( EVT_ACTIVEX );

for my $ieevent ( @Wx::ActiveX::activexIEeventexports ) {
    my $methodcode = 'sub AXIEEVENT { &Wx::Event::AXIEEVENT( @_ ) ; }';
    $methodcode =~ s/AXIEEVENT/$ieevent/g;
    eval "$methodcode";
}

push @exportconstants, @Wx::ActiveX::activexIEeventexports;
push @EXPORT_OK, @exportconstants;
$EXPORT_TAGS{'everything'} = [ @exportconstants ];
$EXPORT_TAGS{'all'} = [ @exportconstants ];


sub EVT_ACTIVEX($$$$) { &Wx::Event::EVT_ACTIVEX( @_ ); }

1;

