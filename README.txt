######################
# Wx::ActiveX 0.0512 #
######################

  This version of Wx::ActiveX is an update to the current CPAN version 0.05.
  It is provided to allow building Wx::ActiveX against recent versions of
  Wx. The author and maintainer of Wx::ActiveX, 
  ( Graciliano M. P. <gm@virtuasites.com.br> ) - cannot currently be contacted
  via contact details at CPAN. Hopefully, Graciliano will be able to return
  to maintaining Wx::ActiveX at some time in the future.
  
  The original README is included with this distribution as README.txt.original.
  
  Thanks goto the many people who have contributed upodates to Wx::ActiveX via
  the wxPerl mailing lists and rt.cpan.org.  I have merely collated their work.
  
  The names I can trace are:
  
  Simon Flack
  Eric Wilhelm
  Andy Levine
  
  I'm sorry if I missed you off.
  
  Thanks also, of course, to Mattia Barbon and Graciliano Monteiro Passos.
  
  
  Mark Dootson <mdootson@cpan.org>  September 2007
  
  
  
###########
# COMPILE #
###########
  
  This is ActiveX so it is a MSWin specific module.

  You will need Wx >= 0.50 together with Alien::wxWidgets >=0.24.
  
#########
# BUILD #
#########

    If you have built your own Alien::wxWidgets or installed development RPMS
    then the standard methods should work:
  
    MSVC
  
    perl Makefile.PL
    nmake
    nmake test
    nmake install
    
    MinGW
    
    perl Makefile.PL
    dmake
    dmake test
    dmake install
    
    
    If you are using MinGW with ActiveState Perl with a Win32::BuildNumber of 820 
    or lower, then you need ExtUtils:FakeConfig installed and should do:
    
    perl -MConfig_m Makefile.PL
    dmake
    dmake test
    dmake install
    
    
    You don't need ExtUtils:FakeConfig or the -MConfig_m option if your 
    Win32::BuildNumber is 822 or greater. 


###################
# ORIGINAL AUTHOR #
###################

  Graciliano M. P. <gm@virtuasites.com.br>

  Thanks to wxWidgets people and Mattia Barbon for wxPerl! ;-)

  Thanks to Justin Bradford <justin@maxwell.ucsf.edu> and Lindsay Mathieson <lmathieson@optusnet.com.au>,
  that wrote the C classes for wxActiveX and wxIEHtmlWin.

  Thanks to Simon Flack <sf@flacks.net>, for the compatibility of Wx::ActiveX object with Win32::OLE and MingW tests.

  Thanks for the interest of everybody.

Enjoy ;-P

