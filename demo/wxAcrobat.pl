#############################################################################
## Name:        wxAcrobat.pl
## Purpose:     wxAcrobat minimal demo
## Author:      Graciliano M. P.
## Created:     06/02/2003
## RCS-ID:
## Copyright:   (c) 2002 Marcus Friedlaender and Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx;

package MyApp;

  use vars qw(@ISA);
  @ISA=qw(Wx::App);

sub OnInit {
  my( $this ) = @_;

  my( $frame ) = MyFrame->new( "wxAcrobat Minimal demo",
			       Wx::Point->new( 50, 50 ),
			       Wx::Size->new( 450, 350 )
                 );

  $this->SetTopWindow( $frame );
  $frame->Show( 1 );

  1;
}

package MyFrame;
  use vars qw(@ISA);
  @ISA=qw(Wx::Frame);

  use Wx::ActiveX::Acrobat;
  use Wx qw(:sizer);
  use Wx::Event qw(EVT_BUTTON) ;
  use Wx::ActiveX::Event qw(EVT_ACTIVEX) ;
  
  use Wx qw(wxDefaultPosition wxDefaultSize wxDEFAULT wxNORMAL wxTE_MULTILINE wxTE_READONLY);
  
  use FindBin ;

sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( undef, -1, $_[0], $_[1], $_[2] );
  
  $|=1;
  
  (my $file_base = $FindBin::RealBin) =~ s/\//\\/g;

  my $pdf = Wx::ActiveX::Acrobat->new( $this , -1 , wxDefaultPosition , wxDefaultSize );

  $pdf->LoadFile("$file_base\\test.pdf");

  print $pdf->ActivexInfos;
  
  my $top_s = Wx::BoxSizer->new( wxVERTICAL ) ;
  $top_s->Add( $pdf, 1, wxGROW|wxALL, 0 ) ;

  $this->SetSizer( $top_s );
  $this->SetAutoLayout( 1 );
  
  return( $this ) ;
}

package main;

  my( $app ) = MyApp->new();
  $app->MainLoop();

exit ;

# Local variables: #
# mode: cperl #
# End: #
