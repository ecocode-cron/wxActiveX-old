#############################################################################
## Name:        wxIE.pl
## Purpose:     wxIE minimal demo
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

  my( $frame ) = MyFrame->new( "wxIE Minimal demo",
                   Wx::Point->new( 50, 50 ),
                   Wx::Size->new( 550, 350 )
                             );

  $this->SetTopWindow( $frame );
  $frame->Show( 1 );

  1;
}

package MyFrame;
  use vars qw(@ISA);
  @ISA=qw(Wx::Frame);

  use Wx::ActiveX::IE ;
  use Wx qw(:sizer);
  use Wx::Event qw(EVT_BUTTON) ;
  use Wx::ActiveX::Event qw(EVT_ACTIVEX EVT_ACTIVEX_IE_NEWWINDOW2 EVT_ACTIVEX_IE_STATUSTEXTCHANGE) ;
  
  use Wx qw(wxDefaultPosition wxDefaultSize wxDEFAULT wxNORMAL);

sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( undef, -1, $_[0], $_[1], $_[2] );
  
  $|=1;

  my $html_id = 501 ;

  my $IE = $this->{IE} = Wx::ActiveX::IE->new( $this , $html_id , wxDefaultPosition , wxDefaultSize );
  $IE->LoadUrl("http://wxperl.sf.net") ;

    Wx::LogStatus( "ACTIVEX_IE EVENT LIST:" );

  for(0..($IE->GetEventCount)-1) {
    my $n = $IE->GetEventName($_) ;
    Wx::LogStatus( "  $_> $n" );
  }
  
  EVT_ACTIVEX($this,$IE,"BeforeNavigate2",sub{
    my ( $obj , $evt ) = @_ ;
    my $url = $evt->{URL} ;
    Wx::LogStatus( "ACTIVEX_IE BeforeNavigate2 >> $url" );
  }) ;
  
  EVT_ACTIVEX_IE_NEWWINDOW2($this,$IE,sub{
    my ( $obj , $evt ) = @_ ;  
    $evt->{Cancel} = 1 ;
    Wx::LogStatus( "ACTIVEX_IE NewWindow2 >> **CANCEL**" );
  }) ;
  
  EVT_ACTIVEX_IE_STATUSTEXTCHANGE($this,$IE,sub{
    my ( $obj , $evt ) = @_ ;
    my $status = $this->{STATUS} ;
    $status->SetValue($evt->{Text});
  });

  my $top_s = Wx::BoxSizer->new( wxVERTICAL );
  my $but_s = Wx::BoxSizer->new( wxHORIZONTAL );
  my $but_s2 = Wx::BoxSizer->new( wxHORIZONTAL );
  
  my $LoadUrl = Wx::Button->new( $this, -1, 'LoadUrl' );
  my $LoadString = Wx::Button->new( $this, -1, 'LoadString' );
  my $GoBack = Wx::Button->new( $this, -1, 'GoBack' );
  my $GoForward = Wx::Button->new( $this, -1, 'GoForward' );
  my $GoHome = Wx::Button->new( $this, -1, 'GoHome' );
  my $GoSearch = Wx::Button->new( $this, -1, 'GoSearch' );
  my $Refresh = Wx::Button->new( $this, -1, 'Refresh' );
  my $Stop = Wx::Button->new( $this, -1, 'Stop' );
  my $GetStringSelection = Wx::Button->new( $this, -1, 'GetStringSelection' );
  my $GetText = Wx::Button->new( $this, -1, 'GetText' );
  my $GetTextHTML = Wx::Button->new( $this, -1, 'GetTextHTML' );
  my $Print = Wx::Button->new( $this, -1, 'Print' );
  my $PrintPreview = Wx::Button->new( $this, -1, 'PrintPreview' );
  
  my $status_txt = Wx::TextCtrl->new( $this , -1, "IE Status", wxDefaultPosition, [200,-1] , wxTE_READONLY );
  
  $this->{STATUS} = $status_txt ;

  $but_s->Add( $LoadUrl );
  $but_s->Add( $LoadString );
  $but_s->Add( $GoBack );
  $but_s->Add( $GoForward );
  $but_s->Add( $GoHome );
  $but_s->Add( $Refresh );
  $but_s->Add( $Stop );
  $but_s2->Add( $GoSearch );
  $but_s2->Add( $GetStringSelection );
  $but_s2->Add( $GetText );
  $but_s2->Add( $GetTextHTML );
  $but_s2->Add( $Print );
  $but_s2->Add( $PrintPreview );

  $top_s->Add( $IE, 1, wxGROW|wxALL, 5 );
  $top_s->Add( $status_txt , 0, wxGROW|wxALL, 0);
  $top_s->Add( $but_s, 0, wxALL, 5 );
  $top_s->Add( $but_s2, 0, wxALL, 5 );

  $this->SetSizer( $top_s );
  $this->SetAutoLayout( 1 );

  EVT_BUTTON( $this, $LoadUrl, \&OnLoadUrl );
  EVT_BUTTON( $this, $LoadString, \&OnLoadString );
  EVT_BUTTON( $this, $GoBack, \&OnGoBack );
  EVT_BUTTON( $this, $GoForward, \&OnGoForward );
  EVT_BUTTON( $this, $GoHome, \&OnGoHome );
  EVT_BUTTON( $this, $GoSearch, \&OnGoSearch );
  EVT_BUTTON( $this, $Refresh, \&OnRefresh );
  EVT_BUTTON( $this, $Stop, \&OnStop );
  EVT_BUTTON( $this, $GetStringSelection, \&OnGetStringSelection );
  EVT_BUTTON( $this, $GetText, \&OnGetText );
  EVT_BUTTON( $this, $GetTextHTML, \&OnGetTextHTML );
  EVT_BUTTON( $this, $Print, \&OnPrint );
  EVT_BUTTON( $this, $PrintPreview, \&OnPrintPreview );
  
  print $IE->ActivexInfos ;
  
  return( $this ) ;
}


#########
# QUERY #
#########

use Wx qw(wxID_OK wxTE_MULTILINE) ;

no strict ;
no warnings;

sub Query {
  my ( $text_init , $width , $height , $multy) = @_ ;
  
  $width = 200 if ($width < 20) ;
  $height = -1 if ($height < 1) ;
  
  my $dialog = Wx::Dialog->new($this , -1 , "Query" , wxDefaultPosition, wxDefaultSize,) ;
  my $sizer = Wx::BoxSizer->new( wxHORIZONTAL );
  
  my $txt_flag ;
  if ( $multy ) { $txt_flag = $txt_flag|wxTE_MULTILINE ;}
  
  my $txt = Wx::TextCtrl->new( $dialog , -1 , $text_init , wxDefaultPosition , [$width,$height] , $txt_flag ) ;
  my $ok = Wx::Button->new($dialog, wxID_OK , 'OK');

  $sizer->Add( $txt );
  $sizer->Add( $ok ) ;
  
  $dialog->SetSizer( $sizer );
  $dialog->SetAutoLayout( 1 );  
  
  $sizer->Fit( $dialog );
  $sizer->SetSizeHints( $dialog );
  
  $dialog->ShowModal() ;
  
  my $val = $txt->GetValue() ;
  
  $dialog->Destroy() ;

  return( $val ) ;
}

sub OnPrint {
  my ($this, $event) = @_ ;
  $this->{IE}->Print(1) ;
}

sub OnPrintPreview {
  my ($this, $event) = @_ ;
  $this->{IE}->PrintPreview ;
}

sub OnLoadUrl {
  my ($this, $event) = @_ ;
  my $url = Query("http://wxperl.sf.net") ;
  $this->{IE}->LoadUrl($url) ;
}

sub OnLoadString {
  my ($this, $event) = @_ ;
  my $html = Query(q`<html>
<body bgcolor="#FFFFFF">
  <center><b>wxIE Test</b></center>
</body>
</html>
`,400,300,1) ;
  $this->{IE}->LoadString($html) ;

}

sub OnGoBack {
  my ($this, $event) = @_ ;
  $this->{IE}->GoBack() ;

}

sub OnGoForward {
  my ($this, $event) = @_ ;
  $this->{IE}->GoForward() ;

}

sub OnGoHome {
  my ($this, $event) = @_ ;
  $this->{IE}->GoHome() ;

}

sub OnGoSearch {
  my ($this, $event) = @_ ;
  $this->{IE}->GoSearch() ;

}

sub OnRefresh {
  my ($this, $event) = @_ ;
  $this->{IE}->Refresh() ;

}

sub OnStop {
  my ($this, $event) = @_ ;
  $this->{IE}->Stop() ;

}

sub OnGetStringSelection {
  my ($this, $event) = @_ ;
  my $val = $this->{IE}->GetStringSelection() ;
  Wx::LogMessage( "GetStringSelection: $val" );
}

sub OnGetText {
  my ($this, $event) = @_ ;
  my $val = $this->{IE}->GetText() ;
  my $html = Query($val,400,300,1) ;
}

sub OnGetTextHTML {
  my ($this, $event) = @_ ;
  my $val = $this->{IE}->GetText(1) ;
  my $html = Query($val,400,300,1) ;
}

package main;

  my( $app ) = MyApp->new();
  $app->MainLoop();

exit ;

# Local variables: #
# mode: cperl #
# End: #
