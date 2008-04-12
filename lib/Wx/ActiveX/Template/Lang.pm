#############################################################################
## Name:        lib/Wx/ActiveX/Template.pm
## Purpose:     Languages for Wx/ActiveX/Template.pm
## Author:      Mark Dootson
## Created:     2008-04-7
## SVN-ID:      $Id$
## Copyright:   (c) 2008 Mark Dootson
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################
use utf8;
package Wx::ActiveX::Template::Lang;
use strict;
require Exporter;
use base qw( Exporter );
use Wx qw( :everything );
use Wx::Locale;

our $VERSION = 0.11;

our @EXPORT = qw( T );

our $language = Wx::ConfigBase::Get()->Read('userlanguage', 'default');

# languages we support
our %languages = (fr    => 'fr_FR',
                  en    => 'en_GB',
                  it    => 'it_IT',
                  de    => 'de_DE',
                  pt    => 'pt_PT',
                  es    => 'es_ES',
                  fr_FR => 'fr_FR',
                  en_GB => 'en_GB',
                  en_US => 'en_US',
                  it_IT => 'it_IT',
                  de_DE => 'de_DE',
                  pt_PT => 'pt_PT',
                  es_ES => 'es_ES',
                 );

our $defaultlanguage = 'en_GB'; # got to have some default

#get user language
if($language eq 'default')
{
    $language = $defaultlanguage; #got to have a default
    
    # get language constant with static function
    my $langid = Wx::Locale::GetSystemLanguage;
    
    if( $langid != wxLANGUAGE_UNKNOWN ) {
        # get a Wx::Locale object without changing anything
        my $langname = Wx::Locale->new($langid)->GetCanonicalName;
        $language = $langname if $langname;
    }
}

# read the data
our %langstringdata = ();
foreach my $key (keys(%languages)) {
    $langstringdata{$languages{$key}} = { namenumber => 0,
                                          values => {},
                                         };
}

my $readlang = 'UNKNOWN';
my $namenumber = 0;
my @lines = <DATA>;
for (@lines) {
    chomp;
    #print qq(PARSING: $_\n);
    my $line = $_;
    if( $line =~ /^(\d+|LANG):*(.+)/ ) {
        if ($1 eq 'LANG') {
            #change readlang
            ($readlang, $namenumber) = split(/:/, $2);
            #print qq(Loading language $readlang, $namenumber\n);
            $langstringdata{$readlang}->{namenumber} = $namenumber;
            next;
        } else {
            #print qq(Writing $1 for $readlang = $2\n);
            $langstringdata{$readlang}->{values}->{$1} = $2;
        }
    } else {
        next;
    }
}

&set_language($language);


sub T {
    my $defaultval = shift;
    return $defaultval;
    # noop till implemented
}


sub set_language {
    my $lang = shift;
    my $mappedlang = $lang;
    # have we got an exact match
    if(defined($languages{$lang})) {
        $mappedlang = $languages{$lang};
    } else {
        # check for root
        my($root, $sublang) = split(/_/, $lang);
        if(defined($languages{$root})) {
            $mappedlang = $languages{$root};
        } else {
            $mappedlang = $defaultlanguage;
        }
    }
    # save
    Wx::ConfigBase::Get()->Write('userlanguage', $mappedlang );
}

1;

__DATA__

# language app strings

LANG:en_GB:101
101: English United Kingdom
102: English United States
103: French
104: German
105: Italian
106: Dutch
107: Portuguese
108: Spanish
190: Select language for application menus and messages.

201: Wx::ActiveX Control Class Templates - Version
202: Version

302: Query the ActiveX Control
303: Exit the Application.
305: Choose the application display language.
307: Show Help Contents
308: Show application About Box

10001: &File
10002: &Run Query
10003: E&xit
10004: Op&tions
10005: Select &Language
10006: &Help
10007: Con&tents
10008: A&bout Box

LANG:en_US:102
101: English United Kingdom
102: English United States
103: French
104: German
105: Italian
106: Dutch
107: Portuguese
108: Spanish
190: Select language for application menus and messages.

LANG:fr_FR:103
101: Anglais Royaume-Uni
102: anglais États-Unis
103: Français
104: Allemand
105: Italien
106: Néerlandais
107: Portugais
108: Espagnol
190: Choix de la langue pour les menus et les messages.

LANG:de_DE:104
101: English Vereinigtes Königreich
102: English Vereinigte Staaten
103: Französisch
104: Deutsch
105: Italienisch
106: Niederländisch
107: Portugiesisch
108: Spanisch
190: Wählen Sie die Sprache für die Anwendung von Menüs und Meldungen.

LANG:it_IT:105
101: Inglese Regno Unito
102: Inglese Stati Uniti
103: Francese
104: Tedesco
105: Italiano
106: Olandese
107: Portoghese
108: Spagnolo
190: Selezionare la lingua per l'applicazione dei menu e dei messaggi.

LANG:nl_NL:106
101: Engels Verenigd Koninkrijk
102: Engels Verenigde Staten
103: Frans
104: Duits
105: Italiaans
106: Nederlands
107: Portugees
108: Spaans
190: Kies de taal voor de toepassing menu's en berichten.

LANG:pt_PT:107
101: Inglês Reino Unido
102: Estados Unidos
103: Francês
104: Alemão
105: Italiano
106: Holandês
107: Português
108: Espanhol
190: Escolha um idioma para a aplicação menus e mensagens.

LANG:es_ES:108
101: Inglés Reino Unido
102: Inglés Estados Unidos
103: Francés
104: Alemán
105: Italiano
106: Holandés
107: Portugués
108: Español
190: Selecciona el idioma para los menús y los mensajes de solicitud.



