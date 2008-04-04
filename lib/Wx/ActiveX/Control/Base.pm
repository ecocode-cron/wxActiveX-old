#############################################################################
## Name:        lib/Wx/ActiveX/Document.pm
## Purpose:     Wx::ActiveX::Document (Internet Explorer Wrapper)
## Author:      Mark Dootson.
## Created:     2008-04-02
## SVN-ID:      $Id: Document.pm 2351 2008-04-04 09:09:08Z mdootson $
## Copyright:   (c) 2002 - 2008 Graciliano M. P., Mattia Barbon, Mark Dootson
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#----------------------------------------------------------------------------
 package Wx::ActiveX::Control::Base;
#----------------------------------------------------------------------------

use strict;
use Wx;
use Wx::Event;
use Wx::ActiveX; # also loads Wx::IEHtmlWin

package Wx::ActiveX;

our @EXPORT_OK = ();
our %EXPORT_TAGS{'everything'} = \@EXPORT_OK;
our %EXPORT_TAGS{'all'} = \@EXPORT_OK;
our %EXPORT_TAGS{'activex'} = \@EXPORT_OK;

# Base ACTIVEX Event
sub EVT_ACTIVEX($$$$) {$_[0]->Connect(_[1],-1,&Wx::ActiveXEvent::RegisterActiveXEvent( $_[2] ),Wx::ActiveXEvent::ActiveXEventSub( $_[3])};


package Wx::ActiveX::Event;

# support pre v0.06 code

our @EXPORT_OK = ();
our %EXPORT_TAGS{'everything'} = \@EXPORT_OK;
our %EXPORT_TAGS{'all'} = \@EXPORT_OK;
our %EXPORT_TAGS{'activex'} = \@EXPORT_OK;

# Base ACTIVEX Event
sub EVT_ACTIVEX($$$$) {$_[0]->Connect(_[1],-1,&Wx::ActiveXEvent::RegisterActiveXEvent( $_[2] ),Wx::ActiveXEvent::ActiveXEventSub( $_[3])};






sub new {
    my $class = shift;
    my $self = bless {}, $class;
    return $self;
}




1;
