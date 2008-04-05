#############################################################################
## Name:        lib/Wx/ActiveX/Acrobat.pm
## Purpose:     Wx::ActiveX::Acrobat (Acrobat Reader)
## Author:      Simon Flack
## Created:     23/07/2003
## SVN-ID:      $Id$
## Copyright:   (c) 2003 Simon Flack
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::ActiveX::Acrobat ;
use Wx::ActiveX ;
use strict;

use vars qw($AUTOLOAD $ACROBAT_VERSION) ;

use base 'Wx::ActiveX';
our $VERSION = '0.06'; # Wx::ActiveX Version

my $PROGID  = "PDF.PdfCtrl.5" ;

sub new {
    my $class = shift;
    my $parent = shift;
    my $self = $class->SUPER::new( $parent , $PROGID , @_ );
    return $self ;
}

1;

__END__

=head1 NAME

Wx::ActiveX::Acrobat - ActiveX interface for Acrobat.

NOTE: This does not work with the free Acrobat Reader.
Use Wx::ActiveX::Document to load PDF files using the
free Acrobat Reader ActiveX Control.

=head1 VERSION

Version 0.60

=head1 SYNOPSIS

  use Wx::ActiveX::Acrobat ;
  my $acrobat = Wx::ActiveX::Acrobat->new( $parent ,
                                           -1 ,
                                           wxDefaultPosition ,
                                           wxDefaultSize );
  
  $acrobat->LoadFile("./test.pdf");


=head1 DESCRIPTION

ActiveX control for Acrobat Reader. The control inherits from
Wx::ActiveX, and all methods/events from there exit here too.

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
