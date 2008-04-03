#############################################################################
## Name:        lib/Wx/ActiveX/WMPlayer.pm
## Purpose:     Wx::ActiveX::WMPlayer (Windows Media Player)
## Author:      Thiago S. V.
## Modified by:
## Created:     14/04/2003
## SVN-ID:      $Id$
## Copyright:   (c) 2002 Thiago S. V.
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::ActiveX::WMPlayer ;
use Wx::ActiveX ;
use strict ;
use base qw( Wx::ActiveX );

our $VERSION = '0.06';

#######
# NEW #
#######

sub new {
    my $class = shift ;
    my $parent = shift ;
    my $self = $class->SUPER::new( $parent , "MediaPlayer.MediaPlayer.1" , @_ ) ;
    return $self;
}

#######
# END #
#######

1;

__END__

=head1 NAME

Wx::ActiveX::WMPlayer - ActiveX interface for Windows Media Player.

=head1 SYNOPSIS

  use Wx::ActiveX::WMPlayer ;
  my $wm = Wx::ActiveX::WMPlayer->new( $parent , -1 , wxDefaultPosition , wxDefaultSize );
  
  $wm->PropSet("FileName",'C:\movie.avi') ;
  $wm->Play ;
  
  EVT_ACTIVEX($this, $wm ,"PlayStateChange", sub{
    my ( $this , $evt ) = @_ ;
    print "Play Change\n" ;
  }) ;


=head1 DESCRIPTION

ActiveX control for Windows Media Player. The control comes from Wx::ActiveX, and all methods/events from there exit here too.

=head1 new ( PARENT , ID , POS , SIZE )

This will create and return the Windows Media Player object.

=head1 METHODS

See L<Wx::ActiveX>.

=head1 EVENTS

All the events use EVT_ACTIVEX.

=head1 ActivexInfos

  <EVENTS>
    ReadyStateChange
    MouseUp
    MouseMove
    MouseDown
    KeyUp
    KeyPress
    KeyDown
    DblClick
    Click
    PositionChange
    DisplayModeChange
    DVDNotify
    ScriptCommand
    EndOfStream
    Buffering
    Disconnect
    MarkerHit
    NewStream
    Warning
    Error
    OpenStateChange
    PlayStateChange
  </EVENTS>
  
  <PROPS>
    ActiveMovie
    AllowChangeDisplaySize
    AllowScan
    AnimationAtStart
    AudioStream
    AutoRewind
    AutoSize
    AutoStart
    Balance
    Bandwidth
    BaseURL
    BufferingCount
    BufferingProgress
    BufferingTime
    CanPreview
    CanScan
    CanSeek
    CanSeekToMarkers
    CaptioningID
    ChannelDescription
    ChannelName
    ChannelURL
    ClickToPlay
    ClientId
    CodecCount
    ConnectionSpeed
    ContactAddress
    ContactEmail
    ContactPhone
    CreationDate
    CurrentMarker
    CurrentPosition
    CursorType
    DefaultFrame
    DisplayBackColor
    DisplayForeColor
    DisplayMode
    DisplaySize
    Duration
    DVD
    EnableContextMenu
    Enabled
    EnableFullScreenControls
    EnablePositionControls
    EnableTracker
    EntryCount
    ErrorCode
    ErrorCorrection
    ErrorDescription
    FileName
    HasError
    HasMultipleItems
    ImageSourceHeight
    ImageSourceWidth
    InvokeURLs
    IsBroadcast
    IsDurationValid
    Language
    LostPackets
    MarkerCount
    Mute
    NSPlay
    OpenState
    PlayCount
    PlayState
    PreviewMode
    Rate
    ReadyState
    ReceivedPackets
    ReceptionQuality
    RecoveredPackets
    SAMIFileName
    SAMILang
    SAMIStyle
    SelectionEnd
    SelectionStart
    SendErrorEvents
    SendKeyboardEvents
    SendMouseClickEvents
    SendMouseMoveEvents
    SendOpenStateChangeEvents
    SendPlayStateChangeEvents
    SendWarningEvents
    ShowAudioControls
    ShowCaptioning
    ShowControls
    ShowDisplay
    ShowGotoBar
    ShowPositionControls
    ShowStatusBar
    ShowTracker
    SourceLink
    SourceProtocol
    StreamCount
    TransparentAtStart
    VideoBorder3D
    VideoBorderColor
    VideoBorderWidth
    Volume
    WindowlessVideo
  </PROPS>
  
  <METHODS>
    AboutBox()
    AddRef()
    Cancel()
    FastForward()
    FastReverse()
    GetCodecDescription(CodecNum)
    GetCodecInstalled(CodecNum)
    GetCodecURL(CodecNum)
    GetCurrentEntry()
    GetIDsOfNames(riid , rgszNames , cNames , lcid , rgdispid)
    GetMarkerName(MarkerNum)
    GetMarkerTime(MarkerNum)
    GetMediaInfoString(MediaInfoType)
    GetMediaParameter(EntryNum , bstrParameterName)
    GetMediaParameterName(EntryNum , Index)
    GetMoreInfoURL(MoreInfoType)
    GetStreamGroup(StreamNum)
    GetStreamName(StreamNum)
    GetStreamSelected(StreamNum)
    GetTypeInfo(itinfo , lcid , pptinfo)
    GetTypeInfoCount(pctinfo)
    Invoke(dispidMember , riid , lcid , wFlags , pdispparams , pvarResult , pexcepinfo , puArgErr)
    IsSoundCardEnabled()
    Next()
    Open(bstrFileName)
    Pause()
    Play()
    Previous()
    QueryInterface(riid , ppvObj)
    Release()
    SetCurrentEntry(EntryNumber)
    ShowDialog(mpDialogIndex)
    Stop()
    StreamSelect(StreamNum)
  </METHODS>

=head1 NOTE

This package only works for Win32, since it use AtiveX.

=head1 SEE ALSO

L<Wx::ActiveX>, L<Wx>.

=head1 AUTHOR

Thiago S. V. <tsv@terra.com.br>

Thanks to Graciliano M. P. for Wx::ActiveX! ;)

=head1 COPYRIGHT

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut


