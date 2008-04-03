#############################################################################
## Name:        lib/Wx/ActiveX/Event.pm
## Purpose:     Wx::ActiveX events.
## Author:      Graciliano M. P.
## Modified by:
## Created:     01/09/2003
## SVN-ID:      $Id$
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#------------------------------------------------------------------------------------
package Wx::ActiveX::Event;
#------------------------------------------------------------------------------------

use strict;
use Wx;
use Wx::Event;
use base qw( Exporter );

our $VERSION = '0.06';

# VERSION 0.06 = events moved to Wx::Event - existing code supported

#------------------------------------------------------------------------------------
package Wx::ActiveX;
#------------------------------------------------------------------------------------

our $VERSION = '0.06';

our @__wxax_eventlist = qw( DOCUMENT_FRAME_CLOSING );

our @__wxax_eventexports = qw( EVT_ACTIVEX );
push ( @__wxax_eventexports, 'EVENT_ACTIVEX_' . $_ ) for ( @__wxax_eventlist );
    
our @__wxax_IEeventexports = qw(
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

our @__wxax_dynaexports = ();
our @__wxax_eventids = ();
our @__wxax_wxexports = ();

#------------------------------------------------------------------------------------
package Wx::Event;
#------------------------------------------------------------------------------------

#
# Wx::ActiveX
#

for my $eventname( @Wx::ActiveX::__wxax_eventlist ) {
    my $neweventid = Wx::NewEventType;
    my $eventcode = q(
        package Wx;
        sub wxaxEVENT_ACTIVEX_RePLaCEMe () { RePLaCEeVENTid; };
        push @Wx::ActiveX::__wxax_wxexports, 'wxaxEVENT_ACTIVEX_RePLaCEMe';
        package Wx::ActiveX;
        sub EVT_ACTIVEX_RePLaCEMe ($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxaxEVENT_ACTIVEX_RePLaCEMe, $_[2] ) };
        push @Wx::ActiveX::__wxax_dynaexports, 'EVT_ACTIVEX_RePLaCEMe';
    );
    $eventcode =~ s/RePLaCEMe/$eventname/g;
    $eventcode =~ s/RePLaCEeVENTid/$neweventid/g;
    eval "$eventcode";  
}


#
# ActiveX
#

sub EVT_ACTIVEX($$$$) { $_[0]->Connect( $_[1], -1, Wx::ActiveXEvent::RegisterActiveXEvent( $_[2] ) , Wx::ActiveXEvent::ActiveXEventSub( $_[3]) ) }

#
# ActiveX_IE
#

sub EVT_ACTIVEX_IE_BEFORENAVIGATE2 { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"BeforeNavigate2",$_[2]) ;}
sub EVT_ACTIVEX_IE_CLIENTTOHOSTWINDOW { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"ClientToHostWindow",$_[2]) ;}
sub EVT_ACTIVEX_IE_COMMANDSTATECHANGE { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"CommandStateChange",$_[2]) ;}
sub EVT_ACTIVEX_IE_DOCUMENTCOMPLETE { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"DocumentComplete",$_[2]) ;}
sub EVT_ACTIVEX_IE_DOWNLOADBEGIN { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"DownloadBegin",$_[2]) ;}
sub EVT_ACTIVEX_IE_DOWNLOADCOMPLETE { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"DownloadComplete",$_[2]) ;}
sub EVT_ACTIVEX_IE_FILEDOWNLOAD { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"FileDownload",$_[2]) ;}
sub EVT_ACTIVEX_IE_NAVIGATECOMPLETE2 { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"NavigateComplete2",$_[2]) ;}
sub EVT_ACTIVEX_IE_NEWWINDOW2 { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"NewWindow2",$_[2]) ;}
sub EVT_ACTIVEX_IE_ONFULLSCREEN { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"OnFullScreen",$_[2]) ;}
sub EVT_ACTIVEX_IE_ONMENUBAR { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"OnMenuBar",$_[2]) ;}
sub EVT_ACTIVEX_IE_ONQUIT { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"OnQuit",$_[2]) ;}
sub EVT_ACTIVEX_IE_ONSTATUSBAR { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"OnStatusBar",$_[2]) ;}
sub EVT_ACTIVEX_IE_ONTHEATERMODE { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"OnTheaterMode",$_[2]) ;}
sub EVT_ACTIVEX_IE_ONTOOLBAR { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"OnToolBar",$_[2]) ;}
sub EVT_ACTIVEX_IE_ONVISIBLE { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"OnVisible",$_[2]) ;}
sub EVT_ACTIVEX_IE_PROGRESSCHANGE { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"ProgressChange",$_[2]) ;}
sub EVT_ACTIVEX_IE_PROPERTYCHANGE { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"PropertyChange",$_[2]) ;}
sub EVT_ACTIVEX_IE_SETSECURELOCKICON { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"SetSecureLockIcon",$_[2]) ;}
sub EVT_ACTIVEX_IE_STATUSTEXTCHANGE { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"StatusTextChange",$_[2]) ;}
sub EVT_ACTIVEX_IE_TITLECHANGE { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"TitleChange",$_[2]) ;}
sub EVT_ACTIVEX_IE_WINDOWCLOSING { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"WindowClosing",$_[2]) ;}
sub EVT_ACTIVEX_IE_WINDOWSETHEIGHT { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"WindowSetHeight",$_[2]) ;}
sub EVT_ACTIVEX_IE_WINDOWSETLEFT { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"WindowSetLeft",$_[2]) ;}
sub EVT_ACTIVEX_IE_WINDOWSETRESIZABLE { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"WindowSetResizable",$_[2]) ;}
sub EVT_ACTIVEX_IE_WINDOWSETTOP { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"WindowSetTop",$_[2]) ;}
sub EVT_ACTIVEX_IE_WINDOWSETWIDTH { &Wx::Event::EVT_ACTIVEX($_[0],$_[1],"WindowSetWidth",$_[2]) ;}

# tags

push @Wx::Event::EXPORT_OK, ( @Wx::ActiveX::__wxax_IEeventexports, @Wx::ActiveX::__wxax_eventexports, @Wx::ActiveX::__wxax_dynaexports );
$Wx::Event::EXPORT_TAGS{'activex'} = [ @Wx::ActiveX::__wxax_IEeventexports, @Wx::ActiveX::__wxax_eventexports, @Wx::ActiveX::__wxax_dynaexports ];

push @Wx::EXPORT_OK, ( @Wx::ActiveX::__wxax_wxexports  );
$Wx::EXPORT_TAGS{'activex'} = [ @Wx::ActiveX::__wxax_wxexports ];
    
#------------------------------------------------------------------------------------
package Wx::ActiveX::Event;
#------------------------------------------------------------------------------------

# support VERSION < 0.06 code.

our ( @EXPORT_OK, %EXPORT_TAGS );

my @exportconstants = qw( EVT_ACTIVEX );

for my $ieevent ( @Wx::ActiveX::activexIEeventexports ) {
    my $methodcode = 'sub AXIEEVENT { &Wx::Event::AXIEEVENT( @_ ) ; }';
    $methodcode =~ s/AXIEEVENT/$ieevent/g;
    eval "$methodcode";
}

push @exportconstants, @Wx::ActiveX::activexIEeventexports;
push @EXPORT_OK, @exportconstants;
$EXPORT_TAGS{'everything'} = [ @exportconstants ];
$EXPORT_TAGS{'all'} = [ @exportconstants ];


sub EVT_ACTIVEX($$$$) { &Wx::Event::EVT_ACTIVEX( @_ ); }

1;

