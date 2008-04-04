#############################################################################
## Name:        lib/Wx/ActiveX.pm
## Purpose:     Wx::ActiveX
## Author:      Graciliano M. P.
## Created:     25/08/2002
## SVN-ID:      $Id$
## Copyright:   (c) 2002 - 2008 Graciliano M. P., Mattia Barbon, Mark Dootson
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::ActiveX;
use strict;
use Wx;
use Wx::Event;
use vars qw( $AUTOLOAD );

our $VERSION = '0.06';
  
Wx::wx_boot( 'Wx::ActiveX', $VERSION ) ;

our @ISA = qw( Wx::Window Wx::ActiveX::PlBase );

our $__wxax_debug;

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
# Wx::ActiveX::PlBase
#-------------------------------------------

package Wx::ActiveX::PlBase;
use base qw( Exporter );

# base activex events

sub Wx::wxAxEVENT_ACTIVEX () { -1 }

push @Wx::EXPORT_OK, ( 'wxAxEVENT_ACTIVEX' );
$Wx::EXPORT_TAGS{'activex'} = [ 'wxAxEVENT_ACTIVEX' ];

sub Wx::Event::EVT_ACTIVEX($$$$) { $_[0]->Connect( $_[1], -1, Wx::ActiveXEvent::RegisterActiveXEvent( $_[2] ) , Wx::ActiveXEvent::ActiveXEventSub( $_[3]) ) }

push @Wx::Event::EXPORT_OK, ('EVT_ACTIVEX');
$Wx::Event::EXPORT_TAGS{'activex'} = [ 'EVT_ACTIVEX' ];

# load activex event functions

sub LoadActiveXEventType {
    my ($package, $eventname, $interfacename ) = @_;
    my $eventcode = q(     
        sub Wx::Event::EVT_ACTIVEX_RepLAcEevEntNAMe { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"RepLAcEINTerFAcENAMe",$_[2]) ;}
        push @Wx::Event::EXPORT_OK, ('EVT_ACTIVEX_RepLAcEevEntNAMe');
        push @{ $Wx::Event::EXPORT_TAGS{'activex'} }, ( 'EVT_ACTIVEX_RepLAcEevEntNAMe' );
    );
    $eventcode =~ s/RepLAcEevEntNAMe/$eventname/g;
    $eventcode =~ s/RepLAcEINTerFAcENAMe/$interfacename/g;
    Wx::LogMessage("Wx::ActiveX::Event Creating Event\n %s", $eventcode ) if $Wx::ActiveX::__wxax_debug;
    eval "$eventcode";
}

sub LoadStandardEventType {
    my ($package, $eventname, $numparams ) = @_;
    my $eventid = Wx::NewEventType;
    my $eventcode = q(
        sub Wx::wxAxEVENT_ACTIVEX_RepLAcEevEntNAMe () { RepLAcEevEntTYpE };
        push @Wx::EXPORT_OK, ( 'wxAxEVENT_ACTIVEX_RepLAcEevEntNAMe' );
        push @{ $Wx::EXPORT_TAGS{'activex'} }, ( 'wxAxEVENT_ACTIVEX_RepLAcEevEntNAMe' );
        push @Wx::Event::EXPORT_OK, ('EVT_ACTIVEX_RepLAcEevEntNAMe');
        push @{ $Wx::Event::EXPORT_TAGS{'activex'} }, ( 'EVT_ACTIVEX_RepLAcEevEntNAMe' );
        
    );
    if ( $numparams == 2 ) {
        $eventcode .= q( sub Wx::Event::EVT_ACTIVEX_RepLAcEevEntNAMe ($$) { $_[0]->Connect( -1, -1, &Wx::wxAxEVENT_ACTIVEX_RepLAcEevEntNAMe, $_[1] ) }; );
    } elsif( $numparams == 3 ) {
        $eventcode .= q( sub Wx::Event::EVT_ACTIVEX_RepLAcEevEntNAMe ($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxAxEVENT_ACTIVEX_RepLAcEevEntNAMe, $_[2] ) }; );
    } else {
        $eventcode .= q( sub Wx::Event::EVT_ACTIVEX_RepLAcEevEntNAMe ($$$$) { $_[0]->Connect( $_[1], $_[2], &Wx::wxAxEVENT_ACTIVEX_RepLAcEevEntNAMe, $_[3] ) }; );
    }
    $eventcode =~ s/RepLAcEevEntNAMe/$eventname/g;
    $eventcode =~ s/RepLAcEevEntTYpE/$eventid/g;
    Wx::LogMessage("Wx::ActiveX Creating Event\n %s", $eventcode ) if $Wx::ActiveX::__wxax_debug;
    eval "$eventcode";
}

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
  
** You can get the list of ActiveX event names using ListEvents():
  
Each ActiveX event has its own argument list (hash), and the method 'Veto' can be used to ignore the event.
In this example any new window will be canceled, seting $evt->IsAllowed to False:

  EVT_ACTIVEX($this,$activex, "EventX" , sub{
    my ( $obj , $evt ) = @_ ;
    $evt->Veto;
  }) ;

=head1 NOTE

This package only works for Win32, since it uses ActiveX.

=head1 SEE ALSO

L<Wx::ActiveX::IE>, L<Wx::ActiveX::Flash>, L<Wx::ActiveX::WMPlayer>, L<Wx>

=head1 AUTHORS & ACKNOWLEDGEMENTS

Wx::ActiveX has benefited from many contributors:

Graciliano Monteiro Passos - original author

Contributions from:

Simon Flack
Mattia Barbon
Eric Wilhelm
Andy Levine
Mark Dootson

Thanks to Justin Bradford and Lindsay Mathieson
who wrote the C classes for wxActiveX and wxIEHtmlWin.

=head1 COPYRIGHT & LICENSE

Copyright (C) 2002-2008 Authors & Contributors, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 MODULE MAINTAINERS

Mark Dootson <mdootson@cpan.org>

=cut

# Local variables: #
# mode: cperl #
# End: #
