#############################################################################
## Name:        lib/Wx/ActiveX.pm
## Purpose:     Wx::ActiveX
## Author:      Graciliano M. P.
## Modified by:
## Created:     25/08/2002
## SVN-ID:      $Id$
## Copyright:   (c) 2002 Graciliano M. P.
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::ActiveX;
use Wx;
use strict;

use vars qw( $AUTOLOAD );

our $VERSION = '0.06';

our @activexIEeventexports = qw(
    EVT_ACTIVEX_IE_BEFORENAVIGATE2
    EVT_ACTIVEX_IE_CLIENTTOHOSTWINDOW
    EVT_ACTIVEX_IE_COMMANDSTATECHANGE
    EVT_ACTIVEX_IE_DOCUMENTCOMPLETE
    EVT_ACTIVEX_IE_DOWNLOADBEGIN
    EVT_ACTIVEX_IE_DOWNLOADCOMPLETE
    EVT_ACTIVEX_IE_FILEDOWNLOAD
    EVT_ACTIVEX_IE_NAVIGATECOMPLETE2
    EVT_ACTIVEX_IE_NEWWINDOW2
    EVT_ACTIVEX_IE_ONFULLSCREEN
    EVT_ACTIVEX_IE_ONMENUBAR
    EVT_ACTIVEX_IE_ONQUIT
    EVT_ACTIVEX_IE_ONSTATUSBAR
    EVT_ACTIVEX_IE_ONTHEATERMODE
    EVT_ACTIVEX_IE_ONTOOLBAR
    EVT_ACTIVEX_IE_ONVISIBLE
    EVT_ACTIVEX_IE_PROGRESSCHANGE
    EVT_ACTIVEX_IE_PROPERTYCHANGE
    EVT_ACTIVEX_IE_SETSECURELOCKICON
    EVT_ACTIVEX_IE_STATUSTEXTCHANGE
    EVT_ACTIVEX_IE_TITLECHANGE
    EVT_ACTIVEX_IE_WINDOWCLOSING
    EVT_ACTIVEX_IE_WINDOWSETHEIGHT
    EVT_ACTIVEX_IE_WINDOWSETLEFT
    EVT_ACTIVEX_IE_WINDOWSETRESIZABLE
    EVT_ACTIVEX_IE_WINDOWSETTOP
    EVT_ACTIVEX_IE_WINDOWSETWIDTH
);

our @activexeventexports = qw( EVT_ACTIVEX );

push @Wx::Event::EXPORT_OK, ( @activexIEeventexports, @activexeventexports );
$Wx::Event::EXPORT_TAGS{'activex'} = [ @activexIEeventexports, @activexeventexports ];

package Wx::Event;

#
# ActiveX
#

sub EVT_ACTIVEX($$$$) { $_[0]->Connect( $_[1], -1, Wx::ActiveXEvent::RegisterActiveXEvent( $_[2] ) , Wx::ActiveXEvent::ActiveXEventSub( $_[3]) ) }

#
# ActiveX_IE
#

sub EVT_ACTIVEX_IE_BEFORENAVIGATE2 { EVT_ACTIVEX($_[0],$_[1],"BeforeNavigate2",$_[2]) ;}
sub EVT_ACTIVEX_IE_CLIENTTOHOSTWINDOW { EVT_ACTIVEX($_[0],$_[1],"ClientToHostWindow",$_[2]) ;}
sub EVT_ACTIVEX_IE_COMMANDSTATECHANGE { EVT_ACTIVEX($_[0],$_[1],"CommandStateChange",$_[2]) ;}
sub EVT_ACTIVEX_IE_DOCUMENTCOMPLETE { EVT_ACTIVEX($_[0],$_[1],"DocumentComplete",$_[2]) ;}
sub EVT_ACTIVEX_IE_DOWNLOADBEGIN { EVT_ACTIVEX($_[0],$_[1],"DownloadBegin",$_[2]) ;}
sub EVT_ACTIVEX_IE_DOWNLOADCOMPLETE { EVT_ACTIVEX($_[0],$_[1],"DownloadComplete",$_[2]) ;}
sub EVT_ACTIVEX_IE_FILEDOWNLOAD { EVT_ACTIVEX($_[0],$_[1],"FileDownload",$_[2]) ;}
sub EVT_ACTIVEX_IE_NAVIGATECOMPLETE2 { EVT_ACTIVEX($_[0],$_[1],"NavigateComplete2",$_[2]) ;}
sub EVT_ACTIVEX_IE_NEWWINDOW2 { EVT_ACTIVEX($_[0],$_[1],"NewWindow2",$_[2]) ;}
sub EVT_ACTIVEX_IE_ONFULLSCREEN { EVT_ACTIVEX($_[0],$_[1],"OnFullScreen",$_[2]) ;}
sub EVT_ACTIVEX_IE_ONMENUBAR { EVT_ACTIVEX($_[0],$_[1],"OnMenuBar",$_[2]) ;}
sub EVT_ACTIVEX_IE_ONQUIT { EVT_ACTIVEX($_[0],$_[1],"OnQuit",$_[2]) ;}
sub EVT_ACTIVEX_IE_ONSTATUSBAR { EVT_ACTIVEX($_[0],$_[1],"OnStatusBar",$_[2]) ;}
sub EVT_ACTIVEX_IE_ONTHEATERMODE { EVT_ACTIVEX($_[0],$_[1],"OnTheaterMode",$_[2]) ;}
sub EVT_ACTIVEX_IE_ONTOOLBAR { EVT_ACTIVEX($_[0],$_[1],"OnToolBar",$_[2]) ;}
sub EVT_ACTIVEX_IE_ONVISIBLE { EVT_ACTIVEX($_[0],$_[1],"OnVisible",$_[2]) ;}
sub EVT_ACTIVEX_IE_PROGRESSCHANGE { EVT_ACTIVEX($_[0],$_[1],"ProgressChange",$_[2]) ;}
sub EVT_ACTIVEX_IE_PROPERTYCHANGE { EVT_ACTIVEX($_[0],$_[1],"PropertyChange",$_[2]) ;}
sub EVT_ACTIVEX_IE_SETSECURELOCKICON { EVT_ACTIVEX($_[0],$_[1],"SetSecureLockIcon",$_[2]) ;}
sub EVT_ACTIVEX_IE_STATUSTEXTCHANGE { EVT_ACTIVEX($_[0],$_[1],"StatusTextChange",$_[2]) ;}
sub EVT_ACTIVEX_IE_TITLECHANGE { EVT_ACTIVEX($_[0],$_[1],"TitleChange",$_[2]) ;}
sub EVT_ACTIVEX_IE_WINDOWCLOSING { EVT_ACTIVEX($_[0],$_[1],"WindowClosing",$_[2]) ;}
sub EVT_ACTIVEX_IE_WINDOWSETHEIGHT { EVT_ACTIVEX($_[0],$_[1],"WindowSetHeight",$_[2]) ;}
sub EVT_ACTIVEX_IE_WINDOWSETLEFT { EVT_ACTIVEX($_[0],$_[1],"WindowSetLeft",$_[2]) ;}
sub EVT_ACTIVEX_IE_WINDOWSETRESIZABLE { EVT_ACTIVEX($_[0],$_[1],"WindowSetResizable",$_[2]) ;}
sub EVT_ACTIVEX_IE_WINDOWSETTOP { EVT_ACTIVEX($_[0],$_[1],"WindowSetTop",$_[2]) ;}
sub EVT_ACTIVEX_IE_WINDOWSETWIDTH { EVT_ACTIVEX($_[0],$_[1],"WindowSetWidth",$_[2]) ;}


package Wx::ActiveX;
    
Wx::wx_boot( 'Wx::ActiveX', $VERSION ) ;

sub AUTOLOAD {
    my ($method) = ( $AUTOLOAD =~ /:(\w+)$/gs ) ;
    if ($method =~ /^DESTROY$/) { return ;}
    my $activex = shift ;
    return( $activex->Invoke($method,@_) ) ;
}

sub PropSet {
    my ( $activex , $name , $val ) = @_ ;
    
    my $pt = $activex->PropType($name) ;
    
    if ($pt eq 'bool') {
        $activex->PropSetBool($name , $val) ;
    }
    elsif ($pt eq 'long'||$pt eq 'int') {
        $activex->PropSetInt($name , $val) ;
    }
    else {
        $activex->PropSetString($name , $val) ;
    }
}

sub ListEvents {
    my $this = shift ;
    my @events ;
    
    for my $i (0..($this->GetEventCount-1)) {
        my $evt_name = $this->GetEventName($i) ;
        push(@events , $evt_name) if $evt_name ne '' ;
    }
    
    return( @events ) ;
}

sub ListProps {
    my $this = shift ;
    my @props ;
    
    for my $i (0..($this->GetPropCount-1)) {
        my $name = $this->GetPropName($i) ;
        push(@props , $name) if $name ne '' ;
    }
    
    return( @props ) ;
}

sub ListMethods {
    my $this = shift ;
    my @methods ;
    
    for my $i (0..($this->GetMethodCount-1)) {
        my $method = $this->GetMethodName($i) ;
        push(@methods , $method) if $method ne '' ;
    }
    
    return( @methods ) ;
}

sub ListMethods_and_Args {
    my $this = shift ;
    my @methods ;
    
    for my $i (0..($this->GetMethodCount-1)) {
        my $method = $this->GetMethodName($i) ;
        
        my @args ;
        for my $j (0..($this->GetMethodArgCount($i)-1)) {
            my $arg = $this->GetMethodArgName($i,$j) ;
            push(@args , $arg) if $arg ne '' ;
        }
        
        push(@methods , "$method(". join(" , ", @args) .")") if $method ne '' ;
    }
    
    return( @methods ) ;
}

sub ListMethods_and_Args_Hash {
    my $this = shift ;
    my @methods ;
    
    for my $i (0..($this->GetMethodCount-1)) {
        my $method = $this->GetMethodName($i) ;
        
        my @args ;
        for my $j (0..($this->GetMethodArgCount($i)-1)) {
            my $arg = $this->GetMethodArgName($i,$j) ;
            push(@args , $arg) if $arg ne '' ;
        }
        push(@methods , $method , [$method]) if $method ne '' ;
    }

    return( @methods ) ;
}


sub ActivexInfos {
    my $this = shift ;
    my @evts = $this->ListEvents ;
    my @props = $this->ListProps ;
    my @methods = $this->ListMethods_and_Args ;
    
    my $ret ;
    
    $ret .= "<EVENTS>\n" ;
    foreach my $i ( @evts ) { $ret .= "  $i\n" ;}
    $ret .= "</EVENTS>\n" ;
    
    $ret .= "\n<PROPS>\n" ;
    foreach my $i ( @props ) { $ret .= "  $i\n" ;}
    $ret .= "</PROPS>\n" ;
    
    $ret .= "\n<METHODS>\n" ;
    foreach my $i ( @methods ) { $ret .= "  $i\n" ;}
    $ret .= "</METHODS>\n" ;
    return( $ret ) ;
}

#--------------------------------------------
# Wx::ActiveXEvent
#-------------------------------------------

package Wx::ActiveXEvent;
use base qw(Wx::CommandEvent Wx::EvtHandler);

my (%EVT_HANDLES) ;

no strict ;

sub ParamSet {
    my ( $evt , $idx , $val ) = @_ ;
    
    my $pt = $evt->ParamType($idx) ;
    
    if ($pt eq 'bool') {
        $evt->ParamSetBool($idx , $val) ;
    }
    elsif ($pt eq 'long'||$pt eq 'int') {
        $evt->ParamSetInt($idx , $val) ;
    }
    else {
        $evt->ParamSetString($idx , $val) ;
    }
}

sub ActiveXEventSub {
    my ( $sub ) = @_ ;
    
    return(
        sub {
            my $evt = $_[1] ;
            
            $evt = Wx::ActiveX::XS_convert_isa($evt,"Wx::ActiveXEvent") ;
            
            for(0..($evt->ParamCount)-1) {
                my $pn = $evt->ParamName($_);
                my $pv = $evt->ParamVal($_);
                $evt->{$pn} = $pv ;
                $evt->{ParamID}{$pn} = $_ ;
            }
            
            my @ret = &$sub( $_[0] , $evt ) ;
            
            for(0..($evt->ParamCount)-1) {
                my $pn = $evt->ParamName($_);
                my $pv = $evt->ParamVal($_);
                if ($pv ne $evt->{$pn}) { $evt->ParamSet($_, $evt->{$pn} ) ;}
            }    
            
            return( @ret ) ;
        }
    );

}

sub Veto {
    my ($event) = @_;
    $event->{Cancel} = 1;
}

sub DESTROY  { 1 ;}

#--------------------------------------------
# Wx::IEHtmlWin
#-------------------------------------------

package Wx::IEHtmlWin;
use strict ;

our $VERSION = '0.06';


#-------------------------------------------------------
# packages inheritance
#-------------------------------------------------------

no strict;

package Wx::ActiveX;        @ISA = qw( Wx::Window );
package Wx::IEHtmlWin;      @ISA = qw( Wx::ActiveX );

1;

__END__

=head1 NAME

Wx::ActiveX - ActiveX interface.

=head1 DESCRIPTION

Load ActiveX controls for wxWindows.

=head1 SYNOPSIS

  use Wx::ActiveX ;
  my $activex = Wx::ActiveX->new( $this , "ShockwaveFlash.ShockwaveFlash" , 101 , wxDefaultPosition , wxDefaultSize ) ;
  
  $activex->Invoke("LoadMovie",'0',"file:///F:/swf/test.swf") ;
  
  $activex->PropSet("Quality",'Best') ;
  
  my $frames_n = $activex->PropVal("TotalFrames") ;
  
  $activex->Invoke("Play") ;
  
  ... or ...
  
  $activex->Play ;

=head1 METHODS

=head2 new ( PARENT , CONTROL_ID , ID , POS , SIZE )

Create the ActiveX control.

  PARENT        need to be a Wx::Window object.
  CONTROL_ID    The control ID (PROGID/string).

=head2 PropVal ( PROP_NAME )

Get the value of a propriety of the control.

=head2 PropSet ( PROP_NAME , VALUE )

Set a propriety of the control.

  PROP_NAME  The propriety name.
  VALUE      The value(s).

=head2 PropType ( PROP_NAME )

Return the type of the propriety.

=head2 GetEventCount

Returnt the number of events that the control have.

=head2 GetPropCount

Returnt the number of proprieties.

=head2 GetMethodCount

Returnt the number of control methods.

=head2 GetEventName( X )

Returnt the name of the event X, where X is a integer.

=head2 GetPropName( X )

Returnt the name of the propriety X, where X is a integer.

=head2 GetMethodName( X )

Returnt the name of the method X, where X is a integer.

=head2 GetMethodArgCount( MethodX )

Returnt the number of arguments of the MethodX.

=head2 GetMethodArgName( MethodX , ArgX )

Returnt the name of the ArgX of MethodX.

=head2 ListEvents()

Return an ARRAY with all the events names.

=head2 ListProps()

Return an ARRAY with all the proprieties names.

=head2 ListMethods()

Return an ARRAY with all the methods names.

=head2 ListMethods_and_Args()

Return an ARRAY with all the methods names and arguments. like:

  foo(argx, argy)

=head2 ListMethods_and_Args_Hash()

Return a HASH with all the methods names (keys) and arguments (values). The arguments are inside a ARRAY ref:

  my %methods = $activex->ListMethods_and_Args_Hash ;
  my @args = @{ $methods{foo} } ;

=head2 ActivexInfos()

Return a string with all the informations about the ActiveX Control:

  <EVENTS>
    MouseUp
    MouseMove
    MouseDown
  </EVENTS>
  
  <PROPS>
    FileName
  </PROPS>
  
  <METHODS>
    Close()
    Load(file)
  </METHODS>

=head1 Win32::OLE

From version 0.5 Wx::ActiveX is compatible with Win32::OLE objects:

  use Wx::ActiveX ;
  use Win32::OLE ;
  
  my $activex = Wx::ActiveX->new( $this , "ShockwaveFlash.ShockwaveFlash" , 101 , wxDefaultPosition , wxDefaultSize ) ;

  my $OLE = $activex->GetOLE() ;
  $OLE->LoadMovie('0' , "file:///F:/swf/test.swf") ;
  $OLE->Play() ;


=head1 EVENTS

All the events use EVT_ACTIVEX.

  EVT_ACTIVEX($parent , $activex , "EventName" , sub{...} ) ;
  
** You can get the list of ActiveX events using ListEvents():
  
Eache ActiveX event has their own argument list (hash), and the Key 'Cancel' can be used to ignore the event. In this example any new window will be canceled, seting $evt->{Cancel} to true:

  EVT_ACTIVEX($this,$activex, "EventX" , sub{
    my ( $obj , $evt ) = @_ ;
    $evt->{Cancel} = 1 ;
  }) ;

=head1 NOTE

This package only works for Win32, since it use ActiveX.

=head1 SEE ALSO

L<Wx::ActiveX::IE>, L<Wx::ActiveX::Flash>, L<Wx::ActiveX::WMPlayer>, L<Wx>

=head1 AUTHOR

Graciliano M. P. <gm@virtuasites.com.br>

Thanks to Simon Flack <sf@flacks.net>, for the compatibility of Wx::ActiveX objetc with Win32::OLE and MingW tests.

Thanks to wxWindows peoples and Mattia Barbon for wxPerl! ;-P

Thanks to Justin Bradford <justin@maxwell.ucsf.edu> and Lindsay Mathieson <lmathieson@optusnet.com.au>, that wrote the original C++ classes for wxActiveX and wxIEHtmlWin.

=head1 COPYRIGHT

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut

# Local variables: #
# mode: cperl #
# End: #
