#############################################################################
## Name:        XS/IEHtmlWin.xs                                           
## Purpose:     XS for Wx::IEHtmlWin
## Author:      Graciliano M. P.
## Modified by:
## SVN-ID:      $Id$
## Copyright:   (c) 2002 - 2007 Graciliano M. P. and Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include "activex/IEHtmlWin.cpp"

MODULE=Wx PACKAGE=Wx::IEHtmlWin

wxIEHtmlWin*
wxIEHtmlWin::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxPanelNameStr )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name


void
wxIEHtmlWin::LoadUrl( url )
  wxString url

bool
wxIEHtmlWin::LoadString( html )
  wxString html
  
bool
wxIEHtmlWin::LoadStream( is )
  Wx_InputStream* is
  
void
wxIEHtmlWin::SetCharset( charset )
  wxString charset
  
void
wxIEHtmlWin::SetEditMode( seton )
  bool seton
  
bool
wxIEHtmlWin::GetEditMode()

wxString
wxIEHtmlWin::GetStringSelection( asHTML = false )
  bool asHTML

wxString
wxIEHtmlWin::GetText( asHTML = false )
  bool asHTML

bool
wxIEHtmlWin::GoBack()

bool
wxIEHtmlWin::GoForward()

bool
wxIEHtmlWin::GoHome()

bool
wxIEHtmlWin::GoSearch()

bool
wxIEHtmlWin::Refresh( level = 0 )
  int level

bool
wxIEHtmlWin::Stop()

void
wxIEHtmlWin::Print( WithPrompt = false )
  bool WithPrompt

void
wxIEHtmlWin::PrintPreview()


