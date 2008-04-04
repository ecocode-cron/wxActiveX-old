#############################################################################
## Name:        lib/Wx/ActiveX/Event.pm
## Purpose:     Wx::ActiveX events.
## Author:      Graciliano M. P.
## Created:     01/09/2003
## SVN-ID:      $Id$
## Copyright:   (c) 2002 - 2008 Graciliano M. P., Mattia Barbon, Mark Dootson
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::ActiveX::Event;
use vars qw(@EXPORT_OK %EXPORT_TAGS) ;
use strict;
use base 'Exporter';
use Wx::ActiveX::IE;

our $VERSION = '0.06';


# this module retained only to support VERSION < 0.06 code.
# new code should use Wx & Wx::Event constants & EVT subs

@EXPORT_OK = @{ $Wx::Event::EXPORT_TAGS{'activex'} };

$EXPORT_TAGS{'everything'} = \@EXPORT_OK;
$EXPORT_TAGS{'all'} = \@EXPORT_OK;

foreach my $eventname (keys(%Wx::ActiveX::IE::activexevents)) {
    &__activex_event_LoadActiveXEventType( $eventname, $Wx::ActiveX::IE::activexevents{$eventname} );
}

sub __activex_event_LoadActiveXEventType {
    my ( $eventname, $interfacename ) = @_;
    my $eventcode = q(     
        sub Wx::ActiveX::Event::EVT_ACTIVEX_RepLAcEevEntNAMe { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"RepLAcEINTerFAcENAMe",$_[2]) ;}
    );
    $eventcode =~ s/RepLAcEevEntNAMe/$eventname/g;
    $eventcode =~ s/RepLAcEINTerFAcENAMe/$interfacename/g;
    Wx::LogMessage("Wx::ActiveX::Event Creating Event\n %s", $eventcode ) if $Wx::ActiveX::__wxax_debug;
    eval "$eventcode";
}

1;

__END__



