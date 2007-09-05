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

package Wx::ActiveX::Event;
use vars qw(@EXPORT_OK %EXPORT_TAGS) ;
use strict;
use base 'Exporter';

@EXPORT_OK = qw(EVT_ACTIVEX
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

$EXPORT_TAGS{'everything'} = \@EXPORT_OK;
$EXPORT_TAGS{'all'} = \@EXPORT_OK;

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

1;

