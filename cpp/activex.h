/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/activex.h
// Purpose:     c++ wrapper for wxActiveX
// Author:      Graciliano M. P.
// Modified by:
// SVN-ID:      $Id$
// Copyright:   (c) 2002 - 2007 Graciliano M. P
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include "activex/wxactivex.cpp"
#include "cpp/v_cback.h"

class wxPliActiveX:public wxActiveX
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliActiveX );
    WXPLI_DECLARE_V_CBACK();
public:
    WXPLI_DEFAULT_CONSTRUCTOR( wxPliActiveX, "Wx::ActiveX", TRUE );
    WXPLI_CONSTRUCTOR_7( wxPliActiveX, "Wx::ActiveX", TRUE,
                         wxWindow*, const wxString& , wxWindowID,
                         const wxPoint&, const wxSize&, long,
                         const wxString& );

};

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliActiveX, wxActiveX );

// Local variables: //
// mode: c++ //
// End: //
