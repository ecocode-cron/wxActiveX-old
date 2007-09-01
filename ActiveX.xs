/////////////////////////////////////////////////////////////////////////////
// Name:        ActiveX.xs
// Purpose:     XS for Wx::ActiveX
// Author:      Graciliano M. P.
// Modified by:
// Created:     25/08/2002
// RCS-ID:      
// Copyright:   (c) 2002 Graciliano M. P. and Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#undef bool
#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"

#include "activex/wxactivex.cpp"
#include "activex/IEHtmlWin.cpp"

#undef THIS
// do it _AFTER_ OLE headers have been included
#undef THIS

MODULE=Wx__ActiveX

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );
  wxClassInfo::CleanUpClasses();
  wxClassInfo::InitializeClasses();

#undef THIS

MODULE=Wx PACKAGE=Wx::ActiveX

wxActiveX*
wxActiveX::new( parent, progId , id, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxPanelNameStr )
    wxWindow* parent
    wxString progId
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name

int
wxActiveX::GetEventCount()
  CODE:
	RETVAL = THIS->GetEventCount();
  OUTPUT:
    RETVAL
    
wxString
wxActiveX::GetEventName(idx)
    int idx

MODULE=Wx PACKAGE=Wx::ActiveXEvent

wxActiveXEvent*
wxActiveXEvent::new()

wxString
wxActiveXEvent::EventName()

int
wxActiveXEvent::ParamCount()

wxString
wxActiveXEvent::ParamType(idx)
    int idx

wxString
wxActiveXEvent::ParamName(idx)
    int idx
    
wxString
wxActiveXEvent::ParamVal(idx)
    int idx

void    
wxActiveXEvent::ParamSetBool(idx , val)
    int idx
    bool val
    
void    
wxActiveXEvent::ParamSetInt(idx , val)
    int idx
    long val
    
void    
wxActiveXEvent::ParamSetString(idx , val)
    int idx
    wxString val

wxEventType
RegisterActiveXEvent( eventName )
    wxChar* eventName


INCLUDE: XS/IEHtmlWin.xs

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__ActiveX


