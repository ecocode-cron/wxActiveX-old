#############################################################################
## Name:        lib/Wx/ActiveX/Acrobat.pm
## Purpose:     Wx::ActiveX::Acrobat (Acrobat Reader)
## Author:      Simon Flack
## Modified by:
## Created:     23/07/2003
## SVN-ID:      $Id$
## Copyright:   (c) 2003 Simon Flack
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::ActiveX::Acrobat ;
use Wx::ActiveX ;
use strict;

use vars qw(@ISA $VERSION $AUTOLOAD $ACROBAT_VERSION) ;
@ISA     = 'Wx::ActiveX';
$VERSION = '0.01';

my $PROGID  = "PDF.PdfCtrl.5" ;

sub new {
  my $class   = shift;
  my $parent  = shift;

  my $activex = Wx::ActiveX->new($parent , $PROGID , @_) ;
  
  $activex = Wx::ActiveX::hash_ref($activex, $class) ;
  return $activex ;
}

1;

__END__

=head1 NAME

Wx::ActiveX::Acrobat - ActiveX interface for Acrobat Reader.

=head1 SYNOPSIS

  use Wx::ActiveX::Acrobat ;
  my $acrobat = Wx::ActiveX::Acrobat->new( $parent , -1 , wxDefaultPosition , wxDefaultSize );
  
  $acrobat->LoadFile("./test.pdf");


=head1 DESCRIPTION

ActiveX control for Acrobat Reader. The control comes from Wx::ActiveX, and all methods/events from there exit here too.

=head1 new ( PARENT , ID , POS , SIZE )

This will create and return the Acrobat object.

=head1 METHODS

See L<Wx:ActiveX>.

=head1 EVENTS

All the events use EVT_ACTIVEX.

=head1 ActivexInfos

  <EVENTS>
  </EVENTS>
  
  <PROPS>
  </PROPS>
  
  <METHODS>
    AboutBox()
    goBackwardStack()
    goForwardStack()
    gotoFirstPage()
    gotoLastPage()
    gotoNextPage()
    gotoPreviousPage()
    LoadFile(fileName)
    Print()
    printAll()
    printAllFit(shrinkToFit)
    printPages(from , to)
    printPagesFit(from , to , shrinkToFit)
    printWithDialog()
    setCurrentPage(n)
    setLayoutMode(layoutMode)
    setNamedDest(namedDest)
    setPageMode(pageMode)
    setShowScrollbars(On)
    setShowToolbar(On)
    setView(viewMode)
    setViewRect(left , top , width , height)
    setViewScroll(viewMode , offset)
    setZoom(percent)
    setZoomScroll(percent , left , top)
  </METHODS>


=head1 SEE ALSO

L<Wx::ActiveX>, L<Wx>

=head1 AUTHOR

Simon Flack <sf@flacks.net>

Thanks to wxWindows peoples and Mattia Barbon for wxPerl! :P

Thanks to Justin Bradford <justin@maxwell.ucsf.edu> and Lindsay Mathieson <lmathieson@optusnet.com.au>, that wrote the C classes for wxActiveX and wxIEHtmlWin.

=head1 COPYRIGHT

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut


# Local variables: #
# mode: cperl #
# End: #
