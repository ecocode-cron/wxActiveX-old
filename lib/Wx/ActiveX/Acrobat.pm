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

package Wx::ActiveX::Acrobat;
use strict;
use Wx qw( wxDefaultPosition wxDefaultSize wxID_ANY WXK_CONTROL wxTheApp wxNO_BORDER );
use Wx::ActiveX;
use base qw( Wx::ActiveX );
use Wx::Event qw( EVT_COMMAND );

our $VERSION = '0.09'; # Wx::ActiveX Version

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
    my $style = shift || wxNO_BORDER
    my $self = $class->SUPER::new( $parent, $PROGID, $windowid, $pos, $size, @_ );
    return $self;
}

# Override LoadFile method that does not seem to work ???
sub LoadFile {
    my ($self, $url) = @_;
    $self->PropSet('src', $url);
}

# Print - I'm sure this didn't work ?????
sub Print{
    my $self = shift;
    $self->Invoke('Print', 1);
}


1;

__END__


=head1 NAME

Wx::ActiveX::Acrobat - Interface for Acrobat Reader ActiveX Control.

=head1 VERSION

Version 0..09

=head1 SYNOPSIS

    use Wx::ActiveX::Acrobat qw(:acrobat);
    my $acrobat = Wx::ActiveX::Acrobat->new( $parent ,
                                             -1 ,
                                             wxDefaultPosition ,
                                             wxDefaultSize );
    
    ........
    
    # freeze while we setup visuals
    $acrobat->Freeze;
    $acrobat->LoadFile("./test.pdf");
    $acrobat->SetShowToolBar(0);
    $acrobat->SetPageMode(bookmarks);
    $acrobat->Thaw;


=head1 DESCRIPTION

ActiveX control for Acrobat Reader. The control inherits from
Wx::ActiveX, and all methods/events from there are available
here too. Available methods allow setting of toolbars, print
ranges, views and print dialogs from code.

=head1 METHODS

=head2 new

    my $activex = Wx::ActiveX::Acrobat->new( $parent,
                                             $windowId,
                                             $position,
                                             $size );

Creates a new Acrobat ActiveX object

=head2 GoBackwardStack

    $activex->GoBackwardStack();

Goes to the previous view on the view stack, if the previous view exists.
This may be in a different document.

=head2 GoForwardStack

    $activex->GoForwardStack();

Goes to the next view on the view stack, if the next view exists.
This may be in a different document.

=head2 GotoFirstPage

    $activex->GotoFirstPage();

Goes to the first page in the document, maintaining the current location
within the page and zoom level.

=head2 GotoLastPage

    $activex->GotoLastPage();

Goes to the last page in the document, maintaining the current location
within the page and zoom level.

=head2 GotoNextPage

    $activex->GotoNextPage();

Goes to the next page in the document, if it exists. Maintains the current
location within the page and zoom level.

=head2 GotoPreviousPage

    $activex->GotoPreviousPage();

Goes to the previous page in the document, if it exists. Maintains the
current location within the page and zoom level.

=head2 LoadFile

    $activex->LoadFile( $url );

Opens and displays the specified document within the ActiveX control.

=head2 Print

    $activex->Print();

Prints the document showing the standard Acrobat dialog box.

=head2 PrintAll

    $activex->PrintAll();

Prints the entire document without displaying a user dialog box.

=head2 PrintAllFit

    $activex->PrintAllFit();

Prints the entire document without displaying a user dialog box,
and the pages are shrunk, if necessary, to fit into the imageable area
of a page in the printer.

=head2 PrintPages

    $activex->PrintPages( $from, $to );

Prints the specified pages without displaying a user dialog box.

=head2 PrintPagesFit

    $activex->PrintPagesFit( $from, $to );

Prints the specified pages without displaying a user dialog box.

=head2 PrintWithDialog

    $activex->PrintWithDialog();
    
Prints the document according to the options selected in a user dialog
box. This is attached to a separate Acrobat window that will persist.
If you want a dialog you probably want the Print method rather than this.

=head2 SetCurrentHighlight

    $activex->SetCurrentHighlight( $left, $top, $width, $height );

Highlights the text selection within the specified bounding rectangle
on the current page.

=head2 SetCurrentPage

    $activex->SetCurrentPage( $pageno );

Goes to the specified page in the document.

=head2 SetLayoutMode

    $activex->SetLayoutMode( $mode );

Sets the layout mode for a page view according to the specified string.

mode:

    'DontCare'      — use the current user preference
    'SinglePage'    — use single page mode (pre Acrobat 3.0 style)
    'OneColumn'     — use one-column continuous mode
    'TwoColumnLeft' — use two-column continuous mode with the first
                      page on the left
    'TwoColumnRight'— use two-column continuous mode with the first
                      page on the right  

=head2 SetNamedDest

    $activex->SetNamedDest( $destination );

Changes the page view to the named destination in the specified string.

=head2 SetPageMode

    $activex->SetPageMode( $mode );

Sets the page mode according to the specified string.

mode:

    'none'      — displays the document, but does not display bookmarks or
                  thumbnails (default)
    'bookmarks' — displays the document and bookmarks
    'thumbs'    — displays the document and thumbnails

=head2 SetShowScrollbars

    $activex->SetShowScrollbars( $bool );

Determines whether scrollbars will appear in the document view.

=head2 SetShowToolbar

    $activex->SetShowToolbar( $bool );

Determines whether a toolbar will appear in the viewer.

=head2 SetView

    $activex->SetView( $view );

Sets the view of a page according to the specified string.

view:

    'Fit'   — Fits the entire page within the window both vertically
              and horizontally.
    'FitH'  — Fits the entire width of the page within the window.
    'FitV'  — Fits the entire height of the page within the window.
    'FitB'  — Fits the bounding box within the window both vertically
              and horizontally.
    'FitBH' — Fits the width of the bounding box within the window.
    'FitB'  — Fits the height of the bounding box within the window

=head2 SetViewRect

    $activex->SetViewRect( $left, $top, $width, $height );

Sets the view rectangle according to the specified coordinates.

=head2 SetViewScroll

    $activex->SetViewScroll( $view, $offset );
    
Sets the view of a page according to the specified string.

view:

    'Fit'   — Fits the entire page within the window both vertically
              and horizontally.
    'FitH'  — Fits the entire width of the page within the window.
    'FitV'  — Fits the entire height of the page within the window.
    'FitB'  — Fits the bounding box within the window both vertically
              and horizontally.
    'FitBH' — Fits the width of the bounding box within the window.
    'FitBV' — Fits the height of the bounding box within the window

offset:

    The horizontal or vertical coordinate positioned either at
    the left or top edge.

=head2 SetZoom

    $activex->SetZoom( $percent );

Sets the magnification according to the specified value.

percent

    The desired zoom factor, expressed as a percentage. For example,
    1.0 represents a magnification of 100%.

=head2 SetZoomScroll

    $activex->SetZoomScroll(  );
    
Sets the magnification according to the specified value, and scrolls
the page view both horizontally and vertically according to the
specified amounts.

percent

    The desired zoom factor, expressed as a percentage. For example,
    1.0 represents a magnification of 100%.

left

    The horizontal coordinate positioned at the left edge.

top

    The vertical coordinate positioned at the top edge.

=head1 PROPERTIES

=head2 src

    $activex->PropSet('src', 'c:\pathto\myfile.pdf');
    
    $loadedfile = $activex->PropVal('src');

Gets or sets the URL for the document

=head1 EVENTS

    EVT_ACTIVEX_ACROBAT_ONERROR($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_ACROBAT_ONMESSAGE($handler, $axcontrol, \&event_sub);

=head1 ACTIVEX INTERFACE

    my $info = $activex->ActivexInfos();

=head2 Methods

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

=head2 Properties

    messageHandler               (wxVariant)
    src                          (wxString)
    
=head2 Events

    OnError
    OnMessage

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
