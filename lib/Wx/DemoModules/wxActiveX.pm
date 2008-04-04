#############################################################################
## Name:        lib/Wx/DemoModules/wxActiveX.pm
## Purpose:     wxPerl demo helper for Wx::ActiveX
## Author:      Mark Dootson
## Modified by:
## Created:     13/11/2007
## SVN-ID:      $Id$
## Copyright:   (c) 2002 2007 Graciliano M. P. & Mark Dootson
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::DemoModules::wxActiveX;
use strict;
use Wx::ActiveX::IE ;
use Wx qw(:sizer);
use Wx::Event qw( :activex EVT_BUTTON) ;
use Wx qw(wxDefaultPosition wxDefaultSize wxDEFAULT wxNORMAL wxID_OK wxTE_MULTILINE wxTE_READONLY);

use base qw(Wx::Panel);

sub add_to_tags  { qw(windows) }
sub title { 'wxActiveX' }

sub new {
    my $class = shift;
    my $self = $class->SUPER::new( @_ );
    
    my $html_id = Wx::NewId ;
    
    my $IE = $self->{IE} = Wx::ActiveX::IE->new( $self , $html_id , wxDefaultPosition , wxDefaultSize );
    $IE->LoadUrl("http://wxperl.sf.net") ;
  
    Wx::LogStatus( "ACTIVEX_IE EVENT LIST:" );
  
    for(0..($IE->GetEventCount)-1) {
      my $n = $IE->GetEventName($_) ;
      Wx::LogStatus( "  $_> $n" );
    }
    
    EVT_ACTIVEX($self,$IE,"BeforeNavigate2",sub{
      my ( $obj , $evt ) = @_ ;
      my $url = $evt->{URL} ;
      Wx::LogStatus( "ACTIVEX_IE BeforeNavigate2 >> $url" );
    }) ;
    
    EVT_ACTIVEX_IE_NEWWINDOW2($self,$IE,sub{
      my ( $obj , $evt ) = @_ ;  
      $evt->{Cancel} = 1 ;
      Wx::LogStatus( "ACTIVEX_IE NewWindow2 >> **CANCEL**" );
    }) ;
    
    EVT_ACTIVEX_IE_STATUSTEXTCHANGE($self,$IE,sub{
      my ( $obj , $evt ) = @_ ;
      my $status = $self->{STATUS} ;
      $status->SetValue($evt->{Text});
    });
  
    my $top_s = Wx::BoxSizer->new( wxVERTICAL );
    my $but_s = Wx::BoxSizer->new( wxHORIZONTAL );
    my $but_s2 = Wx::BoxSizer->new( wxHORIZONTAL );
    
    my $LoadUrl = Wx::Button->new( $self, -1, 'LoadUrl' );
    my $LoadString = Wx::Button->new( $self, -1, 'LoadString' );
    my $GoBack = Wx::Button->new( $self, -1, 'GoBack' );
    my $GoForward = Wx::Button->new( $self, -1, 'GoForward' );
    my $GoHome = Wx::Button->new( $self, -1, 'GoHome' );
    my $GoSearch = Wx::Button->new( $self, -1, 'GoSearch' );
    my $Refresh = Wx::Button->new( $self, -1, 'Refresh' );
    my $Stop = Wx::Button->new( $self, -1, 'Stop' );
    my $GetStringSelection = Wx::Button->new( $self, -1, 'GetStringSelection' );
    my $GetText = Wx::Button->new( $self, -1, 'GetText' );
    my $GetTextHTML = Wx::Button->new( $self, -1, 'GetTextHTML' );
    my $Print = Wx::Button->new( $self, -1, 'Print' );
    my $PrintPreview = Wx::Button->new( $self, -1, 'PrintPreview' );
    my $OpenDocument = Wx::Button->new( $self, -1, 'Open Document' );
    
    my $status_txt = Wx::TextCtrl->new( $self , -1, "IE Status", wxDefaultPosition, [200,-1] , wxTE_READONLY );
    
    $self->{STATUS} = $status_txt ;
  
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
  
    $self->SetSizer( $top_s );
    $self->SetAutoLayout( 1 );
  
    EVT_BUTTON( $self, $LoadUrl, \&OnLoadUrl );
    EVT_BUTTON( $self, $LoadString, \&OnLoadString );
    EVT_BUTTON( $self, $GoBack, \&OnGoBack );
    EVT_BUTTON( $self, $GoForward, \&OnGoForward );
    EVT_BUTTON( $self, $GoHome, \&OnGoHome );
    EVT_BUTTON( $self, $GoSearch, \&OnGoSearch );
    EVT_BUTTON( $self, $Refresh, \&OnRefresh );
    EVT_BUTTON( $self, $Stop, \&OnStop );
    EVT_BUTTON( $self, $GetStringSelection, \&OnGetStringSelection );
    EVT_BUTTON( $self, $GetText, \&OnGetText );
    EVT_BUTTON( $self, $GetTextHTML, \&OnGetTextHTML );
    EVT_BUTTON( $self, $Print, \&OnPrint );
    EVT_BUTTON( $self, $PrintPreview, \&OnPrintPreview );
    EVT_BUTTON( $self, $OpenDocument, \&OnOpenDocument );
    
    Wx::LogStatus( $IE->ActivexInfos );
    return $self;
}

sub Query {
  my ( $self, $text_init , $width , $height , $multy) = @_ ;
  
  $width = 200 if (defined($width) && ($width < 20)) ;
  $height = -1 if (defined($height) && ($height < 1)) ;
  
  $width ||= 200;
  $height ||= -1;
  
  my $dialog = Wx::Dialog->new($self , -1 , "Query" , wxDefaultPosition, wxDefaultSize,) ;
  my $sizer = Wx::BoxSizer->new( wxHORIZONTAL );
  
  my $txt_flag = 0;
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
  my ($self, $event) = @_ ;
  $self->{IE}->Print(1) ;
}

sub OnPrintPreview {
  my ($self, $event) = @_ ;
  $self->{IE}->PrintPreview ;
}

sub OnLoadUrl {
  my ($self, $event) = @_ ;
  my $url = $self->Query("http://wxperl.sf.net") ;
  $self->{IE}->LoadUrl($url) ;
}

sub OnLoadString {
  my ($self, $event) = @_ ;
  my $html = $self->Query(q`<html>
<body bgcolor="#FFFFFF">
  <center><b>wxIE Test</b></center>
</body>
</html>
`,400,300,1) ;
  $self->{IE}->LoadString($html) ;

}

sub OnGoBack {
  my ($self, $event) = @_ ;
  $self->{IE}->GoBack() ;

}

sub OnGoForward {
  my ($self, $event) = @_ ;
  $self->{IE}->GoForward() ;

}

sub OnGoHome {
  my ($self, $event) = @_ ;
  $self->{IE}->GoHome() ;

}

sub OnGoSearch {
  my ($self, $event) = @_ ;
  $self->{IE}->GoSearch() ;

}

sub OnRefresh {
  my ($self, $event) = @_ ;
  $self->{IE}->Refresh() ;

}

sub OnStop {
  my ($self, $event) = @_ ;
  $self->{IE}->Stop() ;

}

sub OnGetStringSelection {
  my ($self, $event) = @_ ;
  my $val = $self->{IE}->GetStringSelection() ;
  Wx::LogMessage( "GetStringSelection: $val" );
}

sub OnGetText {
  my ($self, $event) = @_ ;
  my $val = $self->{IE}->GetText() ;
  my $html = $self->Query($val,400,300,1) ;
}

sub OnGetTextHTML {
  my ($self, $event) = @_ ;
  my $val = $self->{IE}->GetText(1) ;
  my $html = $self->Query($val,400,300,1) ;
}

sub OnOpenDocument {
    my ($self, $event) = @_ ;
    
    my $dialog = Wx::FileDialog
    
}

1;
