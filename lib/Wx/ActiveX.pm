#############################################################################
## Name:        ActiveX.pm
## Purpose:     Wx::ActiveX
## Author:      Graciliano M. P.
## Modified by:
## Created:     25/08/2002
## RCS-ID:      
## Copyright:   (c) 2002 Graciliano M. P.
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::ActiveX;
use Wx;
use strict;
use vars qw(@ISA $VERSION $XS_NEW $AUTOLOAD);

############
# AUTOLOAD #
############

sub AUTOLOAD {
  my ($method) = ( $AUTOLOAD =~ /:(\w+)$/gs ) ;
  if ($method =~ /^DESTROY$/) { return ;}
  my $activex = shift ;
  return( $activex->Invoke($method,@_) ) ;
}

#########
# BEGIN #
#########

sub BEGIN {
  @ISA = qw(Wx::Window);
  $VERSION = '0.03';
  Wx::wx_boot( 'Wx::ActiveX', $VERSION ) ;
  $XS_NEW = \&new ;
  *new = \&PLnew ;
}

#######
# NEW #
#######

sub PLnew {
  my $class = shift ;
  my $parent = shift ;
  my $id = shift ;
  
  my $activex ;
  
  if ($id =~ /^\s*(\{[\w-]+\})\s*$/s) {
    $id = $1 ;
    $activex = Wx::ActiveX::newID($class,$parent,$id,@_) ;
  }
  else { $activex = &$XS_NEW($class,$parent,$id,@_) ;}
  
  $activex = hash_ref($activex,$class) ;
  return( $activex ) ;
}

###########
# PROPSET #
###########

sub PropSet {
  my ( $activex , $name , $val ) = @_ ;
  
  my $pt = $activex->PropType($name) ;
  
  if ($pt eq 'bool') { $activex->PropSetBool($name , $val) ;}
  elsif ($pt eq 'long'||$pt eq 'int') { $activex->PropSetInt($name , $val) ;}
  else { $activex->PropSetString($name , $val) ;}
}

############
# HASH_REF #
############

sub hash_ref {
  my ( $obj ) = @_ ;
  my $class = ref($_[1]) || $_[1] ;
         
  if ( UNIVERSAL::isa($obj,'SCALAR') ) {
    my $hash = {} ;
    bless($hash , $class) ;
    $hash->{_WXTHIS} = ${$obj} ;
    $hash->{OBJ} = $obj ;
    return( $hash ) ;
  }
  elsif ( !UNIVERSAL::isa($obj,$class) && ref($obj) ) {
    my $hash = {} ;
    bless($hash , $class) ;
    $hash->{_WXTHIS} = $obj->{_WXTHIS} ;
    $hash->{OBJ} = $obj ;
    return( $hash ) ;  
  }
  elsif (! ref($obj)) {
    my $hash = {} ;
    bless($hash , $class) ;
    $hash->{_WXTHIS} = $obj ;
    return( $hash ) ;  
  }
  
  return( $obj ) ;
}

##############
# SCALAR_REF #
##############

sub scalar_ref {
  my ( $obj ) = @_ ;
  my $class = ref($_[1]) || $_[1] ;

  if ($obj !~ /^$class=/ || ref($obj) ne 'SCALAR') {
    my $scalar = \${$obj} ;
    bless($scalar , $class) ;
    return( $obj ) ;
  }
  
  return( $obj ) ;
}

####################
# WX::ACTIVEXEVENT #
####################

package Wx::ActiveXEvent;
use vars qw(@ISA);
@ISA = qw(Wx::CommandEvent Wx::EvtHandler);

my (%EVT_HANDLES) ;

no strict ;

############
# PARAMSET #
############

sub ParamSet {
  my ( $evt , $idx , $val ) = @_ ;
  
  my $pt = $evt->ParamType($idx) ;
  
  if ($pt eq 'bool') { $evt->ParamSetBool($idx , $val) ;}
  elsif ($pt eq 'long'||$pt eq 'int') { $evt->ParamSetInt($idx , $val) ;}
  else { $evt->ParamSetString($idx , $val) ;}
  
}

###################
# ACTIVEXEVENTSUB #
###################

sub ActiveXEventSub {
  my ( $sub ) = @_ ;
  
  return( sub {
    my $evt = $_[1] ;
    
    $evt = Wx::ActiveX::hash_ref($evt,"Wx::ActiveXEvent") ;
    
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
  }) ;
  
}

###########
# DESTROY #
###########

sub DESTROY  { 1 ;}

#######
# END #
#######

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

=head1 EVENTS

All the events use EVT_ACTIVEX.

  EVT_ACTIVEX($parent , $activex , "EventName" , sub{...} ) ;
  
You can get the list of ActiveX events using GetEventName():

  for(0..($activex->GetEventCount)) {
    my $evt_name = $activex->GetEventName($_) ;
    print "$_> $evt_name\n" ;
  }
  
Eache ActiveX event has their own argument list (hash), and the Key 'Cancel' can be used to ignore the event. In this example any new window will be canceled, seting $evt->{Cancel} to true:

  EVT_ACTIVEX($this,$activex, "EventX" , sub{
    my ( $obj , $evt ) = @_ ;
    $evt->{Cancel} = 1 ;
  }) ;

=head1 NOTE

This package only works for Win32, since it use ActiveX.

=head1 SEE ALSO

L<Wx:ActiveX::IE>, L<Wx:ActiveX::Flash>, L<Wx>

=head1 AUTHOR

Graciliano M. P. <gm@virtuasites.com.br>

Thanks to wxWindows peoples and Mattia Barbon for wxPerl! ;-P

Thanks to Justin Bradford <justin@maxwell.ucsf.edu> and Lindsay Mathieson <lmathieson@optusnet.com.au>, that wrote the C classes for wxActiveX and wxIEHtmlWin.

=head1 COPYRIGHT

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut

# Local variables: #
# mode: cperl #
# End: #
