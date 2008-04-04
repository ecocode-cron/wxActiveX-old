#############################################################################
## Name:        lib/Wx/ActiveX/Control/Dynamic.pm
## Purpose:     Base control for dynamic ActiveX controls
## Author:      Mark Dootson.
## Created:     2008-04-04
## SVN-ID:      $Id:$
## Copyright:   (c) 2002 - 2008 Graciliano M. P., Mattia Barbon, Mark Dootson
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::ActiveX::Control::Dynamic;
use strict;

sub new {
    my $class = shift;
    my $self = bless {}, $class;
    return $self;
}


1;
