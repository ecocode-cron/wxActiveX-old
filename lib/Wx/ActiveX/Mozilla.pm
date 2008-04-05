#############################################################################
## Name:        lib/Wx/ActiveX/Mozilla.pm
## Purpose:     Control for Mozilla Browser
## Author:      Mark Dootson.
## Created:     2008-04-05
## SVN-ID:      $Id$
## Copyright:   (c) 2002 - 2008 Graciliano M. P., Mattia Barbon, Mark Dootson
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#----------------------------------------------------------------------------
 package Wx::ActiveX::Mozilla;
#----------------------------------------------------------------------------
use strict;
use Wx::ActiveX;
use base qw( Wx::ActiveX );

our $VERSION = '0.06'; # Wx::ActiveX Version

my $PROGID = 'MozillaBrowser';

sub new {
    my $class = shift;
    # parent must exist
    my $parent = shift;
    my $windowid = shift || -1;
    my $pos = shift || wxDefaultPosition;
    my $size = shift || wxDefaultSize;
    my $self = $class->SUPER::new( $parent, $window_id, $PROGID, $pos, $size, @_ );
    return $self;
}


1;
