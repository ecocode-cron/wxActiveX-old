#############################################################################
## Name:        wxIE.pm
## Purpose:     wxIE minimal demo
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

  my( $frame ) = MyFrame->new( "wxFlash Minimal demo",
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

  use Wx::ActiveX::Flash ;
  use Wx qw(:sizer);
  use Wx::Event qw(EVT_BUTTON) ;
  use Wx::ActiveX::Event qw(EVT_ACTIVEX) ;
  
  use Wx qw(wxDefaultPosition wxDefaultSize wxDEFAULT wxNORMAL wxTE_MULTILINE wxTE_READONLY);
  
  use FindBin ;

sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( undef, -1, $_[0], $_[1], $_[2] );
  
  $|=1;
  
  my $file_base = "file:///$FindBin::RealBin" ;

  my $flash = Wx::ActiveX::Flash->new( $this , -1 , wxDefaultPosition , wxDefaultSize );
  
  $flash->LoadMovie(0,"$file_base/dumy.swf") ;
  $flash->Play ;
  
  my $top_s = Wx::BoxSizer->new( wxVERTICAL );

  my $status_txt = Wx::TextCtrl->new( $this , -1, "", wxDefaultPosition, [200,100] , wxTE_READONLY|wxTE_MULTILINE  );
  $this->{STATUS} = $status_txt ;
  
  EVT_ACTIVEX($this, $flash ,"FSCommand", sub{
    my ( $this , $evt ) = @_ ;
    my $status = $this->{STATUS} ;
    
    my $cmd = $evt->{command} ;
    my $args = $evt->{args} ;
    
    $status->AppendText( "[". ++$this->{CMDX} . "] FSCOMMAND>> $cmd( $args )\n");
  }) ;

  $top_s->Add( $flash, 1, wxGROW|wxALL, 5 );
  $top_s->Add( $status_txt , 0, wxGROW|wxALL, 0);

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
