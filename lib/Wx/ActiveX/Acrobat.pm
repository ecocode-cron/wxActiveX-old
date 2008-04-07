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
use strict;
use Wx qw( wxDefaultPosition wxDefaultSize );
use Wx::ActiveX;
use base qw( Wx::ActiveX );

our $VERSION = '0.08'; # Wx::ActiveX Version

our (@EXPORT_OK, %EXPORT_TAGS);
$EXPORT_TAGS{everything} = \@EXPORT_OK;

my $PROGID = 'AcroPDF.PDF';

my $exporttag = 'acrobat';
my $eventname = 'ACROBAT';
#-----------------------------------------------
# Export event classes
#-----------------------------------------------

# events below implemented as EVT_ACTIVEX_EVENTNAME ($$$)
# e.g EVT_ACTIVEX_SCRIPTCONTROL_ERROR($eventhandler, $control, \&event_function);
# The Event ID will be exported as EVENTID_AX_SCRIPTCONTROL_ERROR

our @activexevents = qw (
    OnError
    OnMessage
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
    #$self->Invoke('AddRef');
    return $self;
}

1;

__END__


=head1 NAME

Wx::ActiveX::Acrobat - ActiveX interface for Acrobat Reader ActiveX Control.

=head1 VERSION

Version 0.60

=head1 SYNOPSIS

  use Wx::ActiveX::Acrobat qw(:acrobat);
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

=head1 EVENTS

    EVT_ACTIVEX_ACROBAT_ONERROR($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_ACROBAT_ONMESSAGE($handler, $axcontrol, \&event_sub);

=head1 METHODS

    AddRef()
    GetIDsOfNames(riid , rgszNames , cNames , lcid , rgdispid)
    GetTypeInfo(itinfo , lcid , pptinfo)
    GetTypeInfoCount(pctinfo)
    GetVersions()
    goBackwardStack()
    goForwardStack()
    gotoFirstPage()
    gotoLastPage()
    gotoNextPage()
    gotoPreviousPage()
    Invoke(dispidMember , riid , lcid , wFlags , pdispparams , pvarResult , pexcepinfo , puArgErr)
    LoadFile(fileName)
    postMessage(strArray)
    Print()
    printAll()
    printAllFit(shrinkToFit)
    printPages(from , to)
    printPagesFit(from , to , shrinkToFit)
    printWithDialog()
    QueryInterface(riid , ppvObj)
    Release()
    setCurrentHighlight(a , b , c , d)
    setCurrentHightlight(a , b , c , d)
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

=head1 PROPERTIES

    messageHandler               (wxVariant)
    src                          (wxString)

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

=head1 CURRENT MAINTAINER

Mark Dootson <mdootson@cpan.org>

=cut


# Local variables: #
# mode: cperl #
# End: #
