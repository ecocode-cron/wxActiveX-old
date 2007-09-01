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

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "activex/wxactivex.cpp"

// do it _AFTER_ OLE headers have been included
#undef THIS

#if WXPL_API_VERSION < 0015

struct my_magic {
  my_magic() : object( NULL ), deleteable( TRUE ) { }
  wxObject*  object ;
  bool       deleteable ;
};

#endif


MODULE=Wx__ActiveX

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );
  wxClassInfo::CleanUpClasses();
  wxClassInfo::InitializeClasses();

#undef THIS

MODULE=Wx PACKAGE=Wx::ActiveX


SV*
XS_hash_ref(obj , klass)
    SV* obj
    const char* klass
  CODE:
    HV* stash = gv_stashpv(klass , 1);

    // already an hash ref, only needs to (re)bless it in
    // the correct class
    if (SvROK(obj) && SvTYPE(SvRV(obj)) >= SVt_PVHV) {
      sv_bless(obj, stash);
      SvREFCNT_inc(obj); // for SV* typemap
      RETVAL = obj;
    }
    else {
      HV* hv = newHV();

      RETVAL = newRV_noinc((SV*)hv);
      sv_bless(RETVAL, stash);
#if defined(WXPL_API_VERSION) && (WXPL_API_VERSION >= 0015)
      void* cpp_obj;

      if (SvROK(obj))
          cpp_obj = wxPli_detach_object( aTHX_ obj );
      else
          cpp_obj = (void*)SvIV(obj);

      wxPli_attach_object( aTHX_ RETVAL, cpp_obj );
#else
      void* cpp_obj;
      if (SvROK(obj)) {
        cpp_obj = (void*)SvIV(SvRV(obj));
        // avoid ->DESTROY
        SvIVX(SvRV(obj)) = 0;
      }
      else
          cpp_obj = (void*)SvIV(obj);

      MAGIC* magic;

      while( !( magic = mg_find( (SV*)hv, '~' ) ) ) {
        my_magic tmp;
        sv_magic( (SV*)hv, 0, '~', (char*)&tmp, sizeof( tmp ) );
      }

      my_magic* ptr = (my_magic*)magic->mg_ptr;
      ptr->object = (wxObject*)cpp_obj;
#endif
    }
  OUTPUT: RETVAL

wxActiveX*
wxActiveX::new( parent, progId , id, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxPanelNameStr )
    wxWindow* parent
    wxString progId
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name

void
wxActiveX::Invoke(name , ...)
    wxString name
  PREINIT:
    wxVariant args, ret;
    int i, max;
  PPCODE:
    args.NullList();

    for(i = 2; i < items; i++){
      wxString argx ;
      WXSTRING_INPUT(argx, wxString, ST(i) );
      args.Append( wxVariant(argx) );
    }
    
    ret = THIS->CallMethod(name , args) ;
    max = ret.GetCount() ;
      
    for(i = 0; i < max; i++) {
      wxString retx = ret[i].GetString() ;
#if wxUSE_UNICODE
      SV* tmp = sv_2mortal( newSVpv( retx.mb_str(wxConvUTF8), 0 ) );
      SvUTF8_on( tmp );
      PUSHs( tmp );
#else
      PUSHs( sv_2mortal( newSVpv( CHAR_P retx.c_str(), 0 ) ) );
#endif
    }


int
wxActiveX::GetMethodCount()

wxString
wxActiveX::GetMethodName(idx)
    int idx

int
wxActiveX::GetMethodArgCount(idx)
    int idx

wxString
wxActiveX::GetMethodArgName(idx , argx)
    int idx
    int argx


int
wxActiveX::GetEventCount()

wxString
wxActiveX::GetEventName(idx)
    int idx


int
wxActiveX::GetPropCount()

wxString
wxActiveX::GetPropName(idx)
    int idx


wxString
wxActiveX::PropType(name)
    wxString name

wxString
wxActiveX::PropVal(name)
    wxString name

void    
wxActiveX::PropSetBool(name , val)
    wxString name
    bool val
    
void    
wxActiveX::PropSetInt(name , val)
    wxString name
    long val

void    
wxActiveX::PropSetString(name , val)
    wxString name
    wxString val

void
wxActiveX::GetOLE()
CODE:
{
#ifdef PERL_5005
  typedef SV* (*MYPROC)(CPERLarg_ HV *, IDispatch *, SV *);
#else
  typedef SV* (*MYPROC)(pTHX_ HV *, IDispatch *, SV *);
#endif

  HMODULE hmodule;
  MYPROC pCreatePerlObject;
  IDispatch * pDispatch;

  ST(0) = &PL_sv_undef;
  hmodule = LoadLibrary("OLE");
  if (hmodule != 0) {
    pCreatePerlObject = (MYPROC) GetProcAddress(hmodule, "CreatePerlObject");
    if (pCreatePerlObject != 0)  {
      HV *stash = gv_stashpv("Win32::OLE", TRUE);
      pDispatch = THIS->GetOLEDispatch();
      pDispatch->AddRef();
#ifdef PERL_5005
      ST(0) = (pCreatePerlObject)(PERL_OBJECT_THIS_ stash, pDispatch, NULL);
#else
      ST(0) = (pCreatePerlObject)(aTHX_ stash, pDispatch, NULL);
#endif
    }
    FreeLibrary(hmodule);
  }
}


######### EVENTS:

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


