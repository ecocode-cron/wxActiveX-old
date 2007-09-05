/////////////////////////////////////////////////////////////////////////////
// Name:        activex/IEHtmlWin.h
// Purpose:     implements wxIEHtmlWin window class
// Author:      Graciliano M. P.
// Modified by:
// SVN-ID:      $Id$
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _IEHTMLWIN_H_
#define _IEHTMLWIN_H_
#pragma warning( disable : 4101 4786)
#pragma warning( disable : 4786)


#include <wx/setup.h>
#include <wx/wx.h>
#include <exdisp.h>
#include <iostream>
using namespace std;

#include "wxactivex.h"


enum wxIEHtmlRefreshLevel
{
	wxIEHTML_REFRESH_NORMAL = 0,
	wxIEHTML_REFRESH_IFEXPIRED = 1,
	wxIEHTML_REFRESH_CONTINUE = 2,
	wxIEHTML_REFRESH_COMPLETELY = 3
};

class IStreamAdaptorBase;

class wxIEHtmlWin : public wxActiveX
{
public:
    wxIEHtmlWin(wxWindow * parent, wxWindowID id = -1,
        const wxPoint& pos = wxDefaultPosition,
        const wxSize& size = wxDefaultSize,
        long style = 0,
        const wxString& name = wxPanelNameStr);
	virtual ~wxIEHtmlWin();

	void LoadUrl(const wxString&);
    bool LoadString(wxString html);
    bool LoadStream(istream *strm);
    bool LoadStream(wxInputStream *is);

	void SetCharset(wxString charset);
    void SetEditMode(bool seton);
    bool GetEditMode();
    wxString GetStringSelection(bool asHTML = false);
	wxString GetText(bool asHTML = false);

    void Print(bool WithPrompt = false);
    void PrintPreview();

	bool GoBack();
	bool GoForward();
	bool GoHome();
	bool GoSearch();

	/// bool Refresh(wxIEHtmlRefreshLevel level);
	bool Refresh(int level);

	bool Stop();

	DECLARE_EVENT_TABLE();

protected:
    void SetupBrowser();
    bool LoadStream(IStreamAdaptorBase *pstrm);

	wxAutoOleInterface<IWebBrowser2>		m_webBrowser;
};

#endif /* _IEHTMLWIN_H_ */
