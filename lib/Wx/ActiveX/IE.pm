#############################################################################
## Name:        IE.pm
## Purpose:     Wx::ActiveX::IE (Internet Explorer)
## Author:      Graciliano M. P.
## Modified by:
## Created:     01/09/2002
## RCS-ID:      
## Copyright:   (c) 2002 Graciliano M. P.
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::ActiveX::IE ;
use Wx::ActiveX ;
use strict ;

use vars qw(@ISA $VERSION);
@ISA = qw(Wx::ActiveX);
$VERSION = '0.02';

#######
# NEW #
#######

sub new {
  my $class = shift ;
  my $ie = Wx::IEHtmlWin->new( @_ ) ;
  $ie = Wx::ActiveX::hash_ref($ie,'Wx::IEHtmlWin') ;
  return( $ie ) ;
}

#################
# WX::IEHTMLWIN #
#################

package Wx::IEHtmlWin;
use vars qw(@ISA);
@ISA = qw(Wx::Window Wx::ActiveX::IE);

1;

__END__

=head1 NAME

Wx::ActiveX::IE - ActiveX interface for Internet Explorer. (Win32)

=head1 SYNOPSIS

  use Wx::ActiveX::IE ;
  my $IE = Wx::ActiveX::IE->new( $parent , -1 , wxDefaultPosition , wxDefaultSize );
  $IE->LoadUrl("http://wxperl.sf.net") ;
  
  EVT_ACTIVEX_IE_BEFORENAVIGATE2($this,$IE,sub{
    my ( $obj , $evt ) = @_ ;
    my $url = $evt->{URL} ;
    print "ACTIVEX_IE BeforeNavigate2 >> $url \n" ;
  }) ;

=head1 DESCRIPTION

This will implement the web browser Internet Explorer in your App, using the
interface Wx::ActiveX.

=head2 new ( PARENT , ID , POS , SIZE )

This will create and return the IE object.

=over 15

=item LoadUrl

Attempts to browse to the url, the control uses its internal (MS) network streams.

=item LoadString

Load the passed HTML string.

=item LoadStream

Load the passed HTML stream. The control takes ownership of the pointer, deleting when finished.

=item SetCharset

Sets the charset of the loaded document.

=item SetEditMode( BOOLEAN )

Set the EditMode ON/OFF.

=item GetEditMode

Return true if the EditMode as set on.

=item GetStringSelection( asHTML )

Get the text selected in the page. If asHTML is true it return the html codes too.

=item GetText( asHTML )

Get all the text of the page. If asHTML is true it return the html codes too.

=item GoBack

Go back in the History.

=item GoForward

Go forward in the History (if it goes back before).

=item GoHome

Go to the Home Page of the browser.

=item GoSearch

Go to the default search page of IE.

=item Refresh( LEVEL )

Refresh the URL. You can set the LEVELs, from 0 to 3, of the refresh:

  0 -> Normal*.
  1 -> If Expired.
  2 -> Continue.
  3 -> Completely.

=item Stop

Stop the download process.

=back

=head1 EVENTS

All the events use EVT_ACTIVEX. For example, the event BeforeNavigate2 can be declared usgin EVT_ACTIVEX:

  EVT_ACTIVEX($parent , $IE , "BeforeNavigate2" , sub{...} ) ;
  
or using the ACTIVEX_IE event table:

  EVT_ACTIVEX_IE_BEFORENAVIGATE2($parent , $IE , sub{...} ) ;
  
To import the events use:

  use Wx::ActiveX::Event qw(EVT_ACTIVEX EVT_ACTIVEX_IE_NEWWINDOW2 EVT_ACTIVEX_IE_STATUSTEXTCHANGE) ;
  ... or ...
  use Wx::ActiveX::Event qw(:all) ;
  
You can get the list of ActiveX events using GetEventName():

  for(0..($IE->GetEventCount)) {
    my $evt_name = $IE->GetEventName($_) ;
    print "$_> $evt_name\n" ;
  }
  
Eache ActiveX event has their own argument list (hash), and the Key 'Cancel' can be used to ignore the event. In this example any new window will be canceled, seting $evt->{Cancel} to true:

  EVT_ACTIVEX_IE_NEWWINDOW2($this,$IE,sub{
    my ( $obj , $evt ) = @_ ;
    $evt->{Cancel} = 1 ;
  }) ;
  
Here are the event table for ACTIVEX_IE:

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

=head1 NOTE

This package only works for Win32, since it use AtiveX.

=head1 SEE ALSO

L<Wx:ActiveX> L<Wx>

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
