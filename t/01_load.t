#!/usr/bin/perl

## SVN-ID:      $Id$

use Test::More tests => 10;

BEGIN {
	use_ok( 'Wx::ActiveX' );
        use_ok( 'Wx::ActiveX::IE' );
        use_ok( 'Wx::ActiveX::Event' );
        use_ok( 'Wx::ActiveX::Acrobat' );
        use_ok( 'Wx::ActiveX::Document' );
        use_ok( 'Wx::ActiveX::Flash' );
        use_ok( 'Wx::ActiveX::WMPlayer' );
        use_ok( 'Wx::ActiveX::Mozilla' );
        use_ok( 'Wx::ActiveX::Browser' );
        use_ok( 'Wx::ActiveX::ScriptControl' );
        #use_ok( 'Wx::ActiveX::Template' );
}

1;

exit 0;

# Local variables: #
# mode: cperl #
# End: #

