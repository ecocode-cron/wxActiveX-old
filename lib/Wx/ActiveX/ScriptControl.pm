#############################################################################
## Name:        lib/Wx/ActiveX/ScriptControl.pm
## Purpose:     Alternative control for MSScriptControl
## Author:      Mark Dootson.
## Created:     2008-04-04
## SVN-ID:      $Id$
## Copyright:   (c) 2002 - 2008 Graciliano M. P., Mattia Barbon, Mark Dootson
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#----------------------------------------------------------------------------
 package Wx::ActiveX::ScriptControl;
#----------------------------------------------------------------------------

#-----------------------------------------------
# Initialise
#-----------------------------------------------

use strict;
use Wx qw( wxDefaultPosition wxDefaultSize );
use Wx::ActiveX;
use base qw( Wx::ActiveX );

our $VERSION = '0.08'; # Wx::ActiveX Version

our (@EXPORT_OK, %EXPORT_TAGS);
$EXPORT_TAGS{everything} = \@EXPORT_OK;

my $PROGID = 'MSScriptControl.ScriptControl';

my $exporttag = 'scriptcontrol';
my $eventname = 'SCRIPTCONTROL';

#-----------------------------------------------
# Export event classes
#-----------------------------------------------

# events below implemented as EVT_ACTIVEX_EVENTNAME ($$$)
# e.g EVT_ACTIVEX_SCRIPTCONTROL_ERROR($eventhandler, $control, \&event_function);
# The Event ID will be exported as EVENTID_AX_SCRIPTCONTROL_ERROR

our @activexevents = qw ( Error Timeout );

# __PACKAGE__->activex_load_standard_event_types( $export_to_namespace, $eventidentifier, $exporttag, $elisthashref );
# __PACKAGE__->activex_load_activex_event_types( $export_to_namespace, $eventidentifier, $exporttag, $elistarrayref );

__PACKAGE__->activex_load_activex_event_types( __PACKAGE__, $eventname, $exporttag, \@activexevents );

sub new {
    my $class = shift;
    # parent must exist
    my $parent = shift;
    my $windowid = shift || -1;
    my $pos = shift || wxDefaultPosition;
    my $size = shift || wxDefaultSize;
    my $self = $class->SUPER::new( $parent, $PROGID, $windowid, $pos, $size, @_ );
    return $self;
}


1;


__END__

=head1 NAME

Wx::ActiveX::ScriptControl - interface to MSScriptControl ActiveX Control

=head1 SYNOPSYS

    use Wx::ActiveX::ScriptControl qw(:scriptcontrol);
    
    ..........
    
    my $activex = Wx::ActiveX::ScriptControl->new($this);
    EVT_ACTIVEX_SCRIPTCONTROL_ERROR($this, $activex, \&on_event_error);
    EVT_ACTIVEX_SCRIPTCONTROL_TIMEOUT($handler, $activex, \&on_event_timeout);
    
    ...........
    
    $activex->_AboutBox();   

=head1 DESCRIPTION

Interface to MSScriptControl ActiveX Control

=head1 EVENTS

    EVT_ACTIVEX_SCRIPTCONTROL_ERROR($handler, $axcontrol, \&event_sub);
    EVT_ACTIVEX_SCRIPTCONTROL_TIMEOUT($handler, $axcontrol, \&event_sub);

=head1 METHODS

    _AboutBox()
    AddCode(Code)
    AddObject(Name , Object , AddMembers)
    AddRef()
    Eval(Expression)
    ExecuteStatement(Statement)
    GetIDsOfNames(riid , rgszNames , cNames , lcid , rgdispid)
    GetTypeInfo(itinfo , lcid , pptinfo)
    GetTypeInfoCount(pctinfo)
    Invoke(dispidMember , riid , lcid , wFlags , pdispparams , pvarResult , pexcepinfo , puArgErr)
    QueryInterface(riid , ppvObj)
    Release()
    Reset()
    Run(ProcedureName , Parameters)

=head1 PROPERTIES

    AllowUI                      (bool)
    CodeObject                   (IDispatch)
    Error                        (*user defined*)
    Language                     (wxString)
    Modules                      (*user defined*)
    Procedures                   (*user defined*)
    SitehWnd                     (long)
    State                        (*user defined*)
    Timeout                      (long)
    UseSafeSubset                (bool)

=head1 SEE ALSO

L<Wx::ActiveX> L<Wx>

=head1 AUTHOR

Mark Dootson <mdootson@cpan.org>

=head1 COPYRIGHT

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut

#
