/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/activex.h
// Purpose:     c++ wrapper for wxActiveX
// Author:      Graciliano M. P.
// Modified by:
// SVN-ID:      $Id:$
// Copyright:   (c) 2002 - 2007 Graciliano M. P
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

class wxPliActiveX:public wxActiveX
{
    public:
        
        static wxPliClassInfo ms_classInfo;
        virtual wxClassInfo *GetClassInfo() const { return &ms_classInfo; }
        wxPliVirtualCallback m_callback;
        wxPliActiveX( const char* package, wxWindow* _arg1, const wxString& _arg2, wxWindowID _arg3,
            const wxPoint& _arg4, const wxSize& _arg5, long _arg6, const wxString& _arg7)
        : wxActiveX( _arg1, _arg2, _arg3, _arg4, _arg5, _arg6, _arg7 ), m_callback( "Wx::ActiveX" )
        {   
            m_callback.SetSelf( wxPli_make_object( this, package ), true );
        }

};

wxPliSelfRef* wxPliGetSelfForwxPliActiveX(wxObject* object)
        { return &((wxPliActiveX *)object)->m_callback; }
        
wxPliClassInfo wxPliActiveX::ms_classInfo((wxChar *) wxT("wxPliActiveX"), 
        &wxActiveX::ms_classInfo, NULL, (int) sizeof(wxPliActiveX),
        (wxPliGetCallbackObjectFn) wxPliGetSelfForwxPliActiveX);


class wxPliIEHtmlWin:public wxIEHtmlWin
{
    public:
        static wxPliClassInfo ms_classInfo;
        virtual wxClassInfo *GetClassInfo() const { return &ms_classInfo; }
        wxPliVirtualCallback m_callback;
        wxPliIEHtmlWin( const char* package, wxWindow* _arg1, wxWindowID _arg2,
            const wxPoint& _arg3, const wxSize& _arg4, long _arg5, const wxString& _arg6)
        : wxIEHtmlWin( _arg1, _arg2, _arg3, _arg4, _arg5, _arg6 ), m_callback( "Wx::IEHtmlWin" )
        {   
            m_callback.SetSelf( wxPli_make_object( this, package ), true );
        }

};

wxPliSelfRef* wxPliGetSelfForwxPliIEHtmlWin(wxObject* object)
        { return &((wxPliIEHtmlWin *)object)->m_callback; }
        
wxPliClassInfo wxPliIEHtmlWin::ms_classInfo((wxChar *) wxT("wxPliIEHtmlWin"), 
        &wxIEHtmlWin::ms_classInfo, NULL, (int) sizeof(wxPliIEHtmlWin),
        (wxPliGetCallbackObjectFn) wxPliGetSelfForwxPliIEHtmlWin);

// Local variables: //
// mode: c++ //
// End: //
