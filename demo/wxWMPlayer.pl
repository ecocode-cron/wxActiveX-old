#############################################################################
## Name:        wxWMPlayer.pl
## Purpose:     WMPlayer minimal demo
## Author:      Graciliano M. P.
## Created:     06/02/2003
## SVN-ID:      $Id$
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

  my( $frame ) = MyFrame->new( "wxWMPlayer Minimal demo",
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

  use Wx::ActiveX::WMPlayer ;
  use Wx qw(:sizer);
  
  use Wx qw(wxDefaultPosition wxDefaultSize);
  
  use FindBin ;

sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( undef, -1, $_[0], $_[1], $_[2] );
  
  $|=1;

  my $wmplayer = Wx::ActiveX::WMPlayer->new( $this , -1 , wxDefaultPosition , wxDefaultSize );

  my $file_base = "file:///$FindBin::RealBin" ;
  $wmplayer->PropSet("FileName","$file_base/movie.mpg") ;
  $wmplayer->Play ;

  my $top_s = Wx::BoxSizer->new( wxVERTICAL );
  $top_s->Add( $wmplayer, 1, wxGROW|wxALL, 5 );

  $this->SetSizer( $top_s );
  $this->SetAutoLayout( 1 );
  
  print $wmplayer->ActivexInfos ;
  
  return( $this ) ;
}


package main;

  my( $app ) = MyApp->new();
  $app->MainLoop();

exit ;


