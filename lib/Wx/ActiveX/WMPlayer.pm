#############################################################################
## Name:        lib/Wx/ActiveX/WMPlayer.pm
## Purpose:     Wx::ActiveX::WMPlayer (Windows Media Player)
## Author:      Thiago S. V.
## Created:     14/04/2003
## SVN-ID:      $Id$
## Copyright:   (c) 2002 - 2008 Thiago S. V., Mattia Barbon, Mark Dootson
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::ActiveX::WMPlayer ;
use strict;
use Wx qw( wxDefaultPosition wxDefaultSize );
use Wx::ActiveX;
use base qw( Wx::ActiveX );

our $VERSION = '0.07'; # Wx::ActiveX Version

our (@EXPORT_OK, %EXPORT_TAGS);
$EXPORT_TAGS{everything} = \@EXPORT_OK;

my $PROGID = 'WMPlayer.OCX';

my $exporttag = 'mediaplayer';
my $eventname = 'MEDIAPLAYER';

#-----------------------------------------------
# Export event classes
#-----------------------------------------------

# events below implemented as EVT_ACTIVEX_EVENTNAME ($$$)
# e.g EVT_ACTIVEX_SCRIPTCONTROL_ERROR($eventhandler, $control, \&event_function);
# The Event ID will be exported as EVENTID_AX_SCRIPTCONTROL_ERROR

our @activexevents = qw (
            OpenStateChange
            StatusChange
            PlayStateChange
            AudioLanguageChange
            EndOfStream
            PositionChange
            MarkerHit
            DurationUnitChange
            ScriptCommand
            Disconnect
            Buffering
            NewStream
            Error
            Warning
            CdromMediaChange
            PlaylistChange
            MediaChange
            CurrentMediaItemAvailable
            CurrentPlaylistChange
            CurrentPlaylistItemAvailable
            CurrentItemChange
            MediaCollectionChange
            MediaCollectionAttributeStringAdded
            MediaCollectionAttributeStringRemoved
            PlaylistCollectionChange
            PlaylistCollectionPlaylistAdded
            PlaylistCollectionPlaylistRemoved
            PlaylistCollectionPlaylistSetAsDeleted
            ModeChange
            MediaCollectionAttributeStringChanged
            MediaError
            DomainChange
            OpenPlaylistSwitch
            SwitchedToPlayerApplication
            SwitchedToControl
            PlayerDockedStateChange
            PlayerReconnect
            Click
            DoubleClick
            KeyDown
            KeyPress
            KeyUp
            MouseDown
            MouseMove
            MouseUp
            DeviceConnect
            DeviceDisconnect
            DeviceStatusChange
            DeviceSyncStateChange
            DeviceSyncError
            CreatePartnershipComplete
);

# __PACKAGE__->activex_load_standard_event_types( $export_to_namespace, $eventidentifier, $exporttag, $elisthashref );
# __PACKAGE__->activex_load_activex_event_types( $export_to_namespace, $eventidentifier, $exporttag, $elistarrayref );

__PACKAGE__->activex_load_activex_event_types( __PACKAGE__, $eventname, $exporttag, \@activexevents );


#-----------------------------------------------
# Instance
#-----------------------------------------------

sub new {
    my $class = shift;
    # parent must exist
    my $parent = shift;
    my $windowid = shift || -1;
    my $pos = shift || wxDefaultPosition;
    my $size = shift || wxDefaultSize;
    my $self = $class->SUPER::new( $parent, $PROGID, $windowid, $pos, $size, @_ );
    return $self;
}

1;

__END__

=head1 NAME

Wx::ActiveX::WMPlayer - ActiveX interface for Windows Media Player.

=head1 SYNOPSIS

    use Wx::ActiveX::WMPlayer;
    my $player = Wx::ActiveX::WMPlayer->new( $parent , -1 , wxDefaultPosition , wxDefaultSize );
  
    EVT_ACTIVEX_MEDIAPLAYER_PLAYSTATECHANGE($evnthandler, $player , \&on_event_playstatechanged);
    
    ...........
    
    $player->PropSet('URL', 'C:\movie.avi') ;

=head1 DESCRIPTION

ActiveX control for Windows Media Player. The control inherits from Wx::ActiveX.

=head1 EVENTS

    EVT_ACTIVEX_MEDIAPLAYER_OPENSTATECHANGE($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_STATUSCHANGE($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_PLAYSTATECHANGE($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_AUDIOLANGUAGECHANGE($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_ENDOFSTREAM($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_POSITIONCHANGE($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_MARKERHIT($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_DURATIONUNITCHANGE($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_SCRIPTCOMMAND($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_DISCONNECT($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_BUFFERING($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_NEWSTREAM($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_ERROR($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_WARNING($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_CDROMMEDIACHANGE($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_PLAYLISTCHANGE($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_MEDIACHANGE($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_CURRENTMEDIAITEMAVAILABLE($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_CURRENTPLAYLISTCHANGE($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_CURRENTPLAYLISTITEMAVAILABLE($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_CURRENTITEMCHANGE($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_MEDIACOLLECTIONCHANGE($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_MEDIACOLLECTIONATTRIBUTESTRINGADDED($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_MEDIACOLLECTIONATTRIBUTESTRINGREMOVED($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_PLAYLISTCOLLECTIONCHANGE($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_PLAYLISTCOLLECTIONPLAYLISTADDED($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_PLAYLISTCOLLECTIONPLAYLISTREMOVED($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_PLAYLISTCOLLECTIONPLAYLISTSETASDELETED($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_MODECHANGE($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_MEDIACOLLECTIONATTRIBUTESTRINGCHANGED($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_MEDIAERROR($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_DOMAINCHANGE($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_OPENPLAYLISTSWITCH($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_SWITCHEDTOPLAYERAPPLICATION($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_SWITCHEDTOCONTROL($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_PLAYERDOCKEDSTATECHANGE($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_PLAYERRECONNECT($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_CLICK($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_DOUBLECLICK($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_KEYDOWN($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_KEYPRESS($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_KEYUP($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_MOUSEDOWN($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_MOUSEMOVE($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_MOUSEUP($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_DEVICECONNECT($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_DEVICEDISCONNECT($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_DEVICESTATUSCHANGE($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_DEVICESYNCSTATECHANGE($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_DEVICESYNCERROR($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_MEDIAPLAYER_CREATEPARTNERSHIPCOMPLETE($handler, $axcontrol, \&event_sub);

=head1 METHODS

    AddRef()
    close()
    GetIDsOfNames(riid , rgszNames , cNames , lcid , rgdispid)
    GetTypeInfo(itinfo , lcid , pptinfo)
    GetTypeInfoCount(pctinfo)
    Invoke(dispidMember , riid , lcid , wFlags , pdispparams , pvarResult , pexcepinfo , puArgErr)
    launchURL(bstrURL)
    newMedia(bstrURL)
    newPlaylist(bstrName , bstrURL)
    openPlayer(bstrURL)
    QueryInterface(riid , ppvObj)
    Release()

=head1 PROPERTIES

    cdromCollection              (*user defined*)
    closedCaption                (*user defined*)
    controls                     (*user defined*)
    currentMedia                 (*user defined*)
    currentPlaylist              (*user defined*)
    dvd                          (*user defined*)
    enableContextMenu            (bool)
    enabled                      (bool)
    Error                        (*user defined*)
    fullScreen                   (bool)
    isOnline                     (bool)
    isRemote                     (bool)
    mediaCollection              (*user defined*)
    network                      (*user defined*)
    openState                    (*user defined*)
    playerApplication            (*user defined*)
    playlistCollection           (*user defined*)
    playState                    (*user defined*)
    settings                     (*user defined*)
    status                       (wxString)
    stretchToFit                 (bool)
    uiMode                       (wxString)
    URL                          (wxString)
    versionInfo                  (wxString)
    windowlessVideo              (bool)

=head1 SEE ALSO

L<Wx::ActiveX>, L<Wx>.

=head1 AUTHOR

Thiago S. V. <tsv@terra.com.br>

Thanks to Graciliano M. P. for Wx::ActiveX! ;)

=head1 COPYRIGHT

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 CURRENT MAINTAINER

Mark Dootson <mdootson@cpan.org>

=cut

#
