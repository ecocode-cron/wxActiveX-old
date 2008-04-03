#############################################################################
## Name:        lib/Wx/ActiveX/Flash.pm
## Purpose:     Wx::ActiveX::Flash (Shockwave Flash)
## Author:      Graciliano M. P.
## Modified by:
## Created:     14/04/2003
## SVN-ID:      $Id$
## Copyright:   (c) 2002 Graciliano M. P.
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::ActiveX::Flash ;
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
  my $self = $class->SUPER::new(  $parent , "ShockwaveFlash.ShockwaveFlash" , @_  );
  
  return( $self ) ;
}

#######
# END #
#######

1;

__END__

=head1 NAME

Wx::ActiveX::Flash - ActiveX interface for Shockwave Flash.

=head1 SYNOPSIS

  use Wx::ActiveX::Flash ;
  my $flash = Wx::ActiveX::Flash->new( $parent , -1 , wxDefaultPosition , wxDefaultSize );
  
  $flash->LoadMovie(0,"file:///F:/swf/test.swf") ;
  $flash->Play ;
  
  EVT_ACTIVEX($this, $flash ,"FSCommand", sub{
    my ( $this , $evt ) = @_ ;
    my $cmd = $evt->{command} ;
    my $args = $evt->{args} ;
    ...
  }) ;


=head1 DESCRIPTION

ActiveX control for Shockwave Flash. The control comes from Wx::ActiveX, and all methods/events from there exit here too.

** You will need to already have the Flash player installed.

=head1 new ( PARENT , ID , POS , SIZE )

This will create and return the Flash object.

=head1 METHODS

See L<Wx:ActiveX>.

=head1 EVENTS

All the events use EVT_ACTIVEX.

=head1 ActivexInfos

  <EVENTS>
    OnReadyStateChange
    FSCommand
    OnProgress
  </EVENTS>
  
  <PROPS>
    AlignMode
    AllowScriptAccess
    BackgroundColor
    Base
    BGColor
    DeviceFont
    EmbedMovie
    FlashVars
    FrameNum
    Loop
    Menu
    Movie
    Playing
    Quality
    Quality2
    ReadyState
    SAlign
    Scale
    ScaleMode
    SWRemote
    TotalFrames
    WMode
  </PROPS>
  
  <METHODS>
    AddRef()
    Back()
    CurrentFrame()
    FlashVersion()
    Forward()
    FrameLoaded(FrameNum)
    GetIDsOfNames(riid , rgszNames , cNames , lcid , rgdispid)
    GetTypeInfo(itinfo , lcid , pptinfo)
    GetTypeInfoCount(pctinfo)
    GetVariable(name)
    GotoFrame(FrameNum)
    Invoke(dispidMember , riid , lcid , wFlags , pdispparams , pvarResult , pexcepinfo , puArgErr)
    IsPlaying()
    LoadMovie(layer , url)
    Pan(x , y , mode)
    PercentLoaded()
    Play()
    QueryInterface(riid , ppvObj)
    Release()
    Rewind()
    SetVariable(name , value)
    SetZoomRect(left , top , right , bottom)
    Stop()
    StopPlay()
    TCallFrame(target , FrameNum)
    TCallLabel(target , label)
    TCurrentFrame(target)
    TCurrentLabel(target)
    TGetProperty(target , property)
    TGetPropertyAsNumber(target , property)
    TGetPropertyNum(target , property)
    TGotoFrame(target , FrameNum)
    TGotoLabel(target , label)
    TPlay(target)
    TSetProperty(target , property , value)
    TSetPropertyNum(target , property , value)
    TStopPlay(target)
    Zoom(factor)
  </METHODS>

=head1 NOTE

This package only works for Win32, since it use AtiveX.

=head1 SEE ALSO

L<Wx::ActiveX>, L<Wx>

=head1 AUTHOR

Graciliano M. P. <gm@virtuasites.com.br>

Thanks to wxWindows peoples and Mattia Barbon for wxPerl! :P

Thanks to Justin Bradford <justin@maxwell.ucsf.edu> and Lindsay Mathieson <lmathieson@optusnet.com.au>, that wrote the original C++ classes for wxActiveX and wxIEHtmlWin.

=head1 COPYRIGHT

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut


# Local variables: #
# mode: cperl #
# End: #
