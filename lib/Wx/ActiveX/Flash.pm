#############################################################################
## Name:        Flash.pm
## Purpose:     Wx::ActiveX::Flash (Shockwave Flash)
## Author:      Graciliano M. P.
## Modified by:
## Created:     14/04/2003
## RCS-ID:      
## Copyright:   (c) 2002 Graciliano M. P.
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::ActiveX::Flash ;
use Wx::ActiveX ;
use strict ;

use vars qw(@ISA $VERSION);
@ISA = qw(Wx::ActiveX);
$VERSION = '0.01';

my $id = 100 ;

#######
# NEW #
#######

sub new {
  my $class = shift ;
  my $parent = shift ;
  my $id = shift || ++$id ;
  my $activex = Wx::ActiveX->new( $parent , "ShockwaveFlash.ShockwaveFlash" , $id , @_ ) ;
  $activex = Wx::ActiveX::hash_ref($activex,'Wx::ActiveX::Flash') ;
  return( $activex ) ;
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

=head1 NOTE

This package only works for Win32, since it use AtiveX.

=head1 SEE ALSO

L<Wx:ActiveX>, L<Wx>

=head1 AUTHOR

Graciliano M. P. <gm@virtuasites.com.br>

Thanks to wxWindows peoples and Mattia Barbon for wxPerl! :P

Thanks to Justin Bradford <justin@maxwell.ucsf.edu> and Lindsay Mathieson <lmathieson@optusnet.com.au>, that wrote the C classes for wxActiveX and wxIEHtmlWin.

=head1 COPYRIGHT

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut


# Local variables: #
# mode: cperl #
# End: #
