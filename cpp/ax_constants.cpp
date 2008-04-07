
 // $Id$

#include <cpp/constants.h>

double activex_constant( const char* name, int arg )
{
    // !package: Wx
    // !parser: sub { $_[0] =~ m<^\s*r\w*\(\s*(\w+)\s*\);\s*(?://(.*))?$> }
    // !tag: grid
#define r( n ) \
    if( strEQ( name, #n ) ) \
        return n;

    WX_PL_CONSTANT_INIT();

    switch( fl )
    {
    case 'A':
        r( wxACTIVEX_CLSID_MOZILLA_BROWSER );
        r( wxACTIVEX_CLSID_WEB_BROWSER );
        break;
    default:
        break;
    }
#undef r

  WX_PL_CONSTANT_CLEANUP();
}

wxPlConstants activex_module( &activex_constant );

