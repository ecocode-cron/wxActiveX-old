#############################################################################
## Name:        lib/Wx/ActiveX/Flash.pm
## Purpose:     Wx::ActiveX::Flash (Shockwave Flash)
## Author:      Graciliano M. P.
## Created:     14/04/2003
## SVN-ID:      $Id$
## Copyright:   (c) 2002 - 2008 Graciliano M. P., Mattia Barbon, Mark Dootson
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::ActiveX::Flash ;
use strict;
use Wx qw( wxDefaultPosition wxDefaultSize );
use Wx::ActiveX;
use base qw( Wx::ActiveX );

our $VERSION = '0.09'; # Wx::ActiveX Version

our (@EXPORT_OK, %EXPORT_TAGS);
$EXPORT_TAGS{everything} = \@EXPORT_OK;

my $PROGID = 'ShockwaveFlash.ShockwaveFlash';

my $exporttag = 'flash';
my $eventname = 'FLASH';

#-----------------------------------------------
# Export event classes
#-----------------------------------------------

# events below implemented as EVT_ACTIVEX_EVENTNAME ($$$)
# e.g EVT_ACTIVEX_SCRIPTCONTROL_ERROR($eventhandler, $control, \&event_function);
# The Event ID will be exported as EVENTID_AX_SCRIPTCONTROL_ERROR

our @activexevents = qw (
        OnReadyStateChange
        FSCommand
        FlashCall
        OnProgress
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

=head2 Events

Events For ShockwaveFlash.ShockwaveFlash

	OnReadyStateChange
	FSCommand
	FlashCall
	OnProgress

=head2 Methods

Methods For ShockwaveFlash.ShockwaveFlash

	AddRef()
	Back()
	CallFunction(request)
	CurrentFrame()
	DisableLocalSecurity()
	EnforceLocalSecurity()
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
	SetReturnValue(returnValue)
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

=head2 Properties

Properties For ShockwaveFlash.ShockwaveFlash

	AlignMode
	AllowFullScreen
	AllowNetworking
	AllowScriptAccess
	BackgroundColor
	Base
	BGColor
	DeviceFont
	EmbedMovie
	FlashVars
	FrameNum
	InlineData
	Loop
	Menu
	Movie
	MovieData
	Playing
	Profile
	ProfileAddress
	ProfilePort
	Quality
	Quality2
	ReadyState
	SAlign
	Scale
	ScaleMode
	SeamlessTabbing
	SWRemote
	TotalFrames
	WMode


=head1 NOTE

This is a Win32 only package as it uses ActiveX.

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
