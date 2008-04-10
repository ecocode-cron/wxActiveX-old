#############################################################################
## Name:        lib/Wx/DemoModules/wxActiveX.pm
## Purpose:     wxPerl Wx::Demo module for Wx::ActiveX
## Author:      Mark Dootson
## Created:     13/11/2007
## SVN-ID:      $Id$
## Copyright:   (c) 2002 - 2008 Graciliano M. P., Mattia Barbon, Mark Dootson
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

BEGIN {
    package Wx::ActiveX;
    our $__wxax_debug; # some info output
    package Wx::DemoModules::wxActiveX;
}

#----------------------------------------------------
 package Wx::DemoModules::wxActiveX;
#----------------------------------------------------

use Wx qw( wxYES_NO wxICON_QUESTION wxCENTRE wxYES wxFD_OPEN wxFD_FILE_MUST_EXIST wxFD_OPEN wxID_CANCEL);
use Wx::ActiveX;
use base qw( Wx::Panel );

sub new {
    my $class = shift;
    my $self = $class->SUPER::new( @_ );
    
    # get Wx::TopLevelWindow;
    my $toplevel = $self->GetParent;
    while(!$toplevel->isa('Wx::TopLevelWindow')) {
        $toplevel = $toplevel->GetParent;
        last if(!$toplevel); # we ended up undef somehow
    }
    $self->{_top_level_window} = $toplevel;
    
    return $self;
}

sub top_level_window {
    my $self = shift;
    return $self->{_top_level_window};
}

sub question_message {
    my($self, $msg) = @_;
    my $title = 'Wx::ActiveX - Wx::Demo - Module';
    if(Wx::MessageBox($msg,
                   $title, 
                   wxYES_NO|wxICON_QUESTION|wxCENTRE, $self) == wxYES) {
        return 1;
    } else {
        return 0;
    }
}

sub open_filename {
    my $self = shift;
    my ($prompt, $mustexist, $filters, $priorfile, $defaultpath) = @_;

    $prompt ||= 'Please Select a File';
    my $style = $mustexist ? (wxFD_OPEN|wxFD_FILE_MUST_EXIST) : wxFD_OPEN;
    
    $defaultpath ||= '';
    $priorfile ||= '';
    
    my $filemask = '';
    if($filters) {
        my @masks = ();
        for my $filter (@$filters) {
            push(@masks, qq($filter->{text} ($filter->{mask})|$filter->{mask}) );
        }
        $filemask = join('|', @masks);
    } else {
        $filemask = 'All Files (*.*)|*.*';
    }
    
    my $parent = $self->top_level_window;    
    my $dialog = Wx::FileDialog->new
        (
            $parent,
            $prompt,
            $defaultpath,
            $priorfile,
            $filemask,
            $style
        );
        
    my $filepath = '';

    if( $dialog->ShowModal == wxID_CANCEL ) {
        $filepath = '';
    } else {
        $filepath = $dialog->GetPath();
    }
    
    return $filepath ? $filepath : undef;   
}


sub tags { [ 'windows/activex' => 'Wx::ActiveX' ] }

#----------------------------------------------------
 package Wx::DemoModules::wxActiveX::BrowserPanel;
#----------------------------------------------------
use strict;
use Wx qw(:sizer wxTE_MULTILINE wxYES_NO wxICON_QUESTION wxCENTRE wxYES wxFD_OPEN wxFD_FILE_MUST_EXIST
           wxID_CANCEL wxTE_READONLY wxDefaultPosition wxDefaultSize wxID_ANY wxID_OK );
use Wx::Event qw( EVT_BUTTON) ;

use Wx::ActiveX qw( EVT_ACTIVEX );           
use Wx::ActiveX::Browser qw( :browser );

use base qw(Wx::DemoModules::wxActiveX);

$Wx::ActiveX::__wxax_debug = 1;

sub new {
    my $class = shift;
    my $self = $class->SUPER::new( @_ );
    return $self;
}

sub InitBrowser {
    my ($self, $browserclass) = @_;
    
    # before creating a Mozilla browser, we need to check if it is actually installed.
    # if it isn't, loading will crash the perl interpreter
    if($browserclass eq 'Wx::ActiveX::Mozilla') {
        my $qmsg = qq(Do you have the Mozilla Browser ActiveX Control Installed?\n);
        $qmsg .= qq(If you do not, and you attempt to load this module, the Perl\n);
        $qmsg .= qq(Interpreter will crash\n);
        $qmsg .= qq(You can get the latest Mozilla ActiveX Control (2005) from\n);
        $qmsg .= qq(http://www.iol.ie/~locka/mozilla/control.htm\n);
        $qmsg .= qq(Do you still want to load the demo module?\n);
        return undef if(!$self->question_message($qmsg));
    }
    
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
    
    # controls
    my $status_txt = Wx::TextCtrl->new( $self , -1, "Browser Status", wxDefaultPosition, [200,-1] , wxTE_READONLY );
    
    my $browser = $browserclass->new( $self , wxID_ANY, wxDefaultPosition, wxDefaultSize );
    
    $self->{STATUS} = $status_txt ;
    $self->{BROWSER} = $browser;
  
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
    $but_s2->Add( $OpenDocument );
  
    $top_s->Add( $browser, 1, wxGROW|wxALL, 5 );
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
    
    EVT_ACTIVEX_BROWSER_NAVIGATECOMPLETE2($self, $browser, sub{
        my ( $obj , $evt ) = @_ ;
        my $url = $evt->{URL} ;
        Wx::LogStatus( "ACTIVEX_BROWSER NavigateComplete2 >> $url" );
    } );
   
    EVT_ACTIVEX($self, $browser, "BeforeNavigate2", sub{
        my ( $obj , $evt ) = @_ ;
        my $url = $evt->{URL} ;
        Wx::LogStatus( "ACTIVEX BeforeNavigate2 >> $url" );
    } );
    
    EVT_ACTIVEX_BROWSER_NEWWINDOW2($self, $browser, sub{
        my ( $obj , $evt ) = @_ ;  
        $evt->Veto ;
        Wx::LogStatus( "ACTIVEX_BROWSER NewWindow2 >> **Vetoed**" );
    }) ;
    
    EVT_ACTIVEX_BROWSER_STATUSTEXTCHANGE($self, $browser, sub{
        my ( $obj , $evt ) = @_ ;
        my $status = $self->{STATUS} ;
        $status->SetValue($evt->{Text});
    });
    
    # get parent frame for Wx::ActiveX::Document
    my $parent = $self;
    while( !$parent->isa('Wx::TopLevelWindow') ) {
        $parent = $parent->GetParent or last;
    }
    if(!$parent) {
        Wx::LogError("%s", 'Unable to find parent Wx::Frame for Wx::ActiveX::Document');
        return undef;
    }
    
    return 1;
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
  $self->{BROWSER}->Print(1) ;
}

sub OnPrintPreview {
  my ($self, $event) = @_ ;
  $self->{BROWSER}->PrintPreview ;
}

sub OnLoadUrl {
  my ($self, $event) = @_ ;
  my $url = $self->Query("http://wxperl.sourceforge.net") ;
  $self->{BROWSER}->LoadUrl($url) ;
}

sub OnLoadString {
  my ($self, $event) = @_ ;
  my $html = $self->Query(q`<html>
<body bgcolor="#FFFFFF">
  <center><b>wxActiveX Browser Test</b></center>
</body>
</html>
`,400,300,1) ;
  $self->{BROWSER}->LoadString($html) ;

}

sub OnGoBack {
  my ($self, $event) = @_ ;
  $self->{BROWSER}->GoBack() ;

}

sub OnGoForward {
  my ($self, $event) = @_ ;
  $self->{BROWSER}->GoForward() ;

}

sub OnGoHome {
  my ($self, $event) = @_ ;
  $self->{BROWSER}->GoHome() ;

}

sub OnGoSearch {
  my ($self, $event) = @_ ;
  $self->{BROWSER}->GoSearch() ;

}

sub OnRefresh {
  my ($self, $event) = @_ ;
  $self->{BROWSER}->Refresh() ;

}

sub OnStop {
  my ($self, $event) = @_ ;
  $self->{BROWSER}->Stop() ;

}

sub OnGetStringSelection {
  my ($self, $event) = @_ ;
  my $val = $self->{BROWSER}->GetStringSelection() ;
  Wx::LogMessage( "GetStringSelection: $val" );
}

sub OnGetText {
  my ($self, $event) = @_ ;
  my $val = $self->{BROWSER}->GetText() ;
  my $html = $self->Query($val,400,300,1) ;
}

sub OnGetTextHTML {
  my ($self, $event) = @_ ;
  my $val = $self->{BROWSER}->GetText(1) ;
  my $html = $self->Query($val,400,300,1) ;
}

sub OnOpenDocument {
    my ($self, $event) = @_ ;
    
    my $prompt = 'Please select a document to load';

    my $style = wxFD_OPEN|wxFD_FILE_MUST_EXIST;
    
    my $defaultpath = '';
    my $priorfile = '';
    my $filemask = 'All Files (*.*)|*.*';
    
    my $parent = $self;
    while( !$parent->isa('Wx::TopLevelWindow') ) {
        $parent = $parent->GetParent or last;
    }
    if(!$parent) {
        Wx::LogError("%s", 'Unable to find parent Wx::Frame for Wx::ActiveX::Document');
        return;
    }
    
    my $dialog = Wx::FileDialog->new
        (
            $parent,
            $prompt,
            $defaultpath,
            $priorfile,
            $filemask,
            $style
        );
        
    my $filepath = '';

    if( $dialog->ShowModal == wxID_CANCEL ) {
        $filepath = '';
    } else {
        $filepath = $dialog->GetPath();
    }
    return if(!$filepath );
    
    my $document = Wx::ActiveX::Document->OpenDocument($parent, $filepath);
    $document->AllowNavigate(0);
    
}

sub OnDocumentFrameClosing {
    my ($parentwindow, $event) = @_ ;
    $event->Veto  if( ! Wx::DemoModules::wxActiveX::question_message(undef, 'Are you sure you wish to close the document frame?') );    
    $event->Skip(0);
}

#----------------------------------------------------
 package Wx::DemoModules::wxActiveX::IE;
#----------------------------------------------------
use strict;
use Wx qw();
use Wx::ActiveX::IE;
use base qw( Wx::DemoModules::wxActiveX::BrowserPanel );

sub new {
    my $class = shift;
    my $self = $class->SUPER::new( @_ );
    $self->InitBrowser('Wx::ActiveX::IE');
    
    return $self;
}

sub add_to_tags { qw(windows/activex) }
sub title { 'IE Browser' }
sub file { __FILE__ }

#----------------------------------------------------
 package Wx::DemoModules::wxActiveX::Mozilla;
#----------------------------------------------------
use strict;
use Wx qw();
use Wx::ActiveX::Mozilla;
use base qw( Wx::DemoModules::wxActiveX::BrowserPanel );

sub new {
    my $class = shift;
    my $self = $class->SUPER::new( @_ );
    $self->InitBrowser('Wx::ActiveX::Mozilla');
    
    return $self;
}

sub add_to_tags { qw(windows/activex) }
sub title { 'Mozilla Browser' }
sub file { __FILE__ }

#----------------------------------------------------
 package Wx::DemoModules::wxActiveX::Acrobat;
#----------------------------------------------------
use strict;
use Wx qw( :sizer wxID_ANY wxDefaultPosition wxDefaultSize wxSYS_COLOUR_BTNFACE );
use Wx::ActiveX::Acrobat qw( :acrobat );;
use base qw( Wx::DemoModules::wxActiveX );
use Wx::Event qw( EVT_BUTTON );

sub new {
    my $class = shift;
    my $self = $class->SUPER::new( @_ );
    
    $self->{acropdf} = Wx::ActiveX::Acrobat->new( $self, wxID_ANY, wxDefaultPosition, wxDefaultSize );
    $self->{btnLoad} = Wx::Button->new($self,wxID_ANY,'Load PDF',wxDefaultPosition, wxDefaultSize);
    $self->{btnPrint} = Wx::Button->new($self,wxID_ANY,'Print Dialog',wxDefaultPosition, wxDefaultSize);
    $self->{btnToggle} = Wx::Button->new($self,wxID_ANY,'Toggle Toolbar',wxDefaultPosition, wxDefaultSize);
     
    my $buttonsizer = Wx::BoxSizer->new(wxHORIZONTAL);
    my $panelsizer = Wx::BoxSizer->new(wxVERTICAL);
    $panelsizer->Add($self->{acropdf}, 1, wxALL|wxEXPAND, 3);
    $buttonsizer->Add($self->{btnLoad}, 0, wxALL|wxEXPAND, 3);
    $buttonsizer->Add($self->{btnPrint}, 0, wxALL|wxEXPAND, 3);
    $buttonsizer->Add($self->{btnToggle}, 0, wxALL|wxEXPAND, 3);
    $panelsizer->Add($buttonsizer, 0, wxALL|wxALIGN_RIGHT, 3);
    
    $self->SetSizer($panelsizer);
    
    EVT_BUTTON($self,$self->{btnLoad},\&on_event_button_load);
    EVT_BUTTON($self,$self->{btnPrint}, sub { shift->{acropdf}->Print(); shift->Skip(1); } );
    EVT_BUTTON($self,$self->{btnToggle},\&on_event_button_toggle);
    
    # don't inherit nbook backcolour
    $self->SetBackgroundColour( Wx::SystemSettings::GetColour(wxSYS_COLOUR_BTNFACE ) ); 
    $self->{_toolbartoggle} = 1;
    
    $self->Layout;
    return $self;
}

sub on_event_button_load {
    my ($self, $event) = @_;
    $event->Skip(1);
    
    #$obj->open_filename ($prompt, $mustexist, $filters, $priorfile, $defaultpath) = @_;
    my $filename = $self->open_filename( 'Please Select a PDF File to Load',
                                         1,
                                         [ { text => 'PDF Files', mask => '*.pdf'}, ]
                                        );
    return if(!$filename );
    
    # freezing reduces screen redraw nastiness
    $self->{acropdf}->Freeze();
    $self->{acropdf}->LoadFile($filename);
    $self->{acropdf}->SetShowToolbar($self->{_toolbartoggle});
    $self->{acropdf}->Thaw();
    
}

sub on_event_button_toggle {
    my ($self, $event) = @_;
    $event->Skip(1);
    $self->{_toolbartoggle} = $self->{_toolbartoggle} ? 0 : 1;
    $self->{acropdf}->Freeze();
    $self->{acropdf}->SetShowToolbar($self->{_toolbartoggle});
    $self->{acropdf}->Thaw();
}

sub add_to_tags { qw(windows/activex) }
sub title { 'Acrobat Reader' }
sub file { __FILE__ }

#----------------------------------------------------
 package Wx::DemoModules::wxActiveX::MediaPlayer;
#----------------------------------------------------
use strict;
use Wx qw( :sizer wxID_ANY wxDefaultPosition wxDefaultSize wxSYS_COLOUR_BTNFACE );
use Wx::ActiveX::WMPlayer qw(:mediaplayer);
use base qw( Wx::DemoModules::wxActiveX );
use Wx::Event qw( EVT_BUTTON );

sub new {
    my $class = shift;
    my $self = $class->SUPER::new( @_ );
    $self->{wmp} = Wx::ActiveX::WMPlayer->new( $self, wxID_ANY, wxDefaultPosition, wxDefaultSize );
    $self->{btnLoad} = Wx::Button->new($self,wxID_ANY,'Load Media File',wxDefaultPosition, wxDefaultSize);
   
    my $buttonsizer = Wx::BoxSizer->new(wxHORIZONTAL);
    my $panelsizer = Wx::BoxSizer->new(wxVERTICAL);
    $panelsizer->Add($self->{wmp}, 1, wxALL|wxEXPAND, 3);
    $buttonsizer->Add($self->{btnLoad}, 0, wxALL|wxEXPAND, 3);
    $panelsizer->Add($buttonsizer, 0, wxALL|wxALIGN_RIGHT, 3);
    
    $self->SetSizer($panelsizer);
    
    EVT_BUTTON($self,$self->{btnLoad},\&on_event_button_load);
    
    # don't inherit nbook backcolour
    $self->SetBackgroundColour( Wx::SystemSettings::GetColour(wxSYS_COLOUR_BTNFACE ) ); 
    
    $self->Layout;
    return $self;
}

sub on_event_button_load {
    my ($self, $event) = @_;
    $event->Skip(1);
    
    #$obj->open_filename ($prompt, $mustexist, $filters, $priorfile, $defaultpath) = @_;
    my $filename = $self->open_filename( 'Please Select a Media File to Load',
                                         1,
                                         [ { text => 'All Files', mask => '*.*'}, ]
                                        );
    return if(!$filename );
    
    $self->{wmp}->PropSet('URL', $filename) ;
    
}

sub add_to_tags { qw(windows/activex) }
sub title { 'Media Player' }
sub file { __FILE__ }

#----------------------------------------------------
 package Wx::DemoModules::wxActiveX::Document;
#----------------------------------------------------
use strict;
use Wx qw();
use Wx::ActiveX;
use base qw( Wx::DemoModules::wxActiveX );

sub new {
    my $class = shift;
    my $self = $class->SUPER::new( @_ );
    

    return $self;
}

sub add_to_tags { qw(windows/activex) }
sub title { 'Document Wrapper' }
sub file { __FILE__ }

#----------------------------------------------------
 package Wx::DemoModules::wxActiveX::Flash;
#----------------------------------------------------
use strict;
use Wx qw( :sizer wxID_ANY wxDefaultPosition wxDefaultSize wxSYS_COLOUR_BTNFACE );
use Wx::ActiveX::Flash qw(:flash);
use base qw( Wx::DemoModules::wxActiveX );
use Wx::Event qw( EVT_BUTTON );

sub new {
    my $class = shift;
    my $self = $class->SUPER::new( @_ );
    $self->{flash} = Wx::ActiveX::Flash->new( $self, wxID_ANY, wxDefaultPosition, wxDefaultSize );
    $self->{btnLoad} = Wx::Button->new($self,wxID_ANY,'Load SWF File',wxDefaultPosition, wxDefaultSize);
   
    my $buttonsizer = Wx::BoxSizer->new(wxHORIZONTAL);
    my $panelsizer = Wx::BoxSizer->new(wxVERTICAL);
    $panelsizer->Add($self->{flash}, 1, wxALL|wxEXPAND, 3);
    $buttonsizer->Add($self->{btnLoad}, 0, wxALL|wxEXPAND, 3);
    $panelsizer->Add($buttonsizer, 0, wxALL|wxALIGN_RIGHT, 3);
    
    $self->SetSizer($panelsizer);
    
    EVT_BUTTON($self,$self->{btnLoad},\&on_event_button_load);
    EVT_ACTIVEX_FLASH_FSCOMMAND($self, $self->{flash},\&on_event_fscommand);
    
    # don't inherit nbook backcolour
    $self->SetBackgroundColour( Wx::SystemSettings::GetColour(wxSYS_COLOUR_BTNFACE ) ); 
    
    $self->Layout;
    return $self;
}

sub on_event_button_load {
    my ($self, $event) = @_;
    $event->Skip(1);
    
    #$obj->open_filename ($prompt, $mustexist, $filters, $priorfile, $defaultpath) = @_;
    my $filename = $self->open_filename( 'Please Select a SWF File to Load',
                                         1,
                                         [ { text => 'Flash Files', mask => '*.swf' }, ]
                                        );
    return if(!$filename );
    
    $self->{flash}->LoadMovie(0, $filename) ;
    $self->{flash}->Play ;
}

sub on_event_fscommand {
    my ( $self , $event ) = @_ ;
    $event->Skip(1);
    my $cmd = $event->{command} ;
    my $args = $event->{args} ;
    
    Wx::LogMessage("Flash FSCOMMAND %s : arguments; %s", $cmd, $args);
    
}

sub add_to_tags { qw(windows/activex) }
sub title { 'Adobe Shockwave' }
sub file { __FILE__ }

#----------------------------------------------------
 package Wx::DemoModules::wxActiveX::ScriptControl;
#----------------------------------------------------
use strict;
use Wx qw();
use Wx::ActiveX;
use base qw( Wx::DemoModules::wxActiveX );

sub new {
    my $class = shift;
    my $self = $class->SUPER::new( @_ );
    
    return $self;
}

sub add_to_tags { qw(windows/activex) }
sub title { 'Microsoft Script Control' }
sub file { __FILE__ }



1;
