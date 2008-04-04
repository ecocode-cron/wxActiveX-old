#############################################################################
## Name:        lib/Wx/ActiveX/Control/Helper.pm
## Purpose:     Helper Helper functions for ActiveX controls
## Author:      Mark Dootson.
## Created:     2008-04-04
## SVN-ID:      $Id:$
## Copyright:   (c) 2002 - 2008 Graciliano M. P., Mattia Barbon, Mark Dootson
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::ActiveX::Control::Helper;
use strict;
use Wx;

our %tranlations = {}


sub new {
    my $class = shift;
    my $packagename = shift;
    my $progid = shift;

    my $self = bless {}, $class;
    my ($progidvar, $exportpack );
    
    $self->{__wach_progid} = $progid;
    
    $self->{__wach_prefix} = \$progidvar;
    $self->{__wach_export} = \$exportpack;
    
    ${$self->{__wach_prefix}} = uc($progid);
    ${$self->{__wach_prefix}} =~ s/\.\d*$//;
    ${$self->{__wach_prefix}} =~ s/\./_/g;
    
    $$self->{__wach_export}} = $packagename;
    
    $self->{__wach_events} = {};
    return $self;
}

sub prefix {
    my $self = shift;
    ${$self->{__wach_prefix}} = shift if ( @_ );
    return ${$self->{__wach_prefix}};
}

sub export_package_name {
    my $self = shift;
    ${$self->{__wach_export}} = shift if ( @_ );
    return ${$self->{__wach_export}};
}

sub add_activex_event {
    my( $self, $namestub ) = @;
    my $event = Wx::ActiveX::Control::Helper::BaseEvent->new(
            $namestub,
            $self->{__wach_prefix},
            $self->{__wach_export}
            2,
            'activex'
            );
    
    push @{ $self->{__wach_events} }, $event;
    return $event;
}

sub add_standard_event {
    my( $self, $namestub, $numvals ) = @;
    my $event = Wx::ActiveX::Control::Helper::BaseEvent->new(
            $namestub,
            $self->{__wach_prefix},
            $self->{__wach_export},
            $numvals || 2,
            'standard'
            );
    
    push @{ $self->{__wach_events} }, $event;
    return $event;
}

package Wx::ActiveX::Control::Helper::BaseEvent;
use strict;
use base qw( Exporter );

sub new {
    my ($class, $namestub, $prefixref, $exportref, $numvals, $type ) = shift;
    my $self = bless {}, $class;
    $self->{__wach_prefix_ref} = $prefixref;
    $self->{__wach_export_ref} = $exportref;
    $self->{__wach_namestub} = $namestub;
    $self->{__wach_event_sub} = uc($namestub);
    $self->{__wach_numvals} = $numvals;
    $self->{__wach_type} = $type;
    return $self;
}

sub event_type {
    shift->{__wach_type};
}

sub event_is_activex {
    my $self = shift;
    return $self->event_type eq 'activex';
}

sub event_is_standard {
    my $self = shift;
    return $self->event_type eq 'standard';
}

sub interface_name {
    my $self = shift;
    return ( $self->event_is_activex ) ? $self->{__wach_namestub} : '';
}

sub event_sub_name {
    my $self = shift;
    return 'EVT_ACTIVEX_' . ${$self->{__wach_prefix_ref}} . '_' . $self->{__wach_event_sub};
}

sub event_sub_code {
    my $self = shift;
    my $code;
    if( $self->event_is_activex ) {
        $code = q(sub RePLaCemExEVENTSUBNAME ($$$) { &Wx::ActiveX::EVT_ACTIVEX($_[0],$_[1],"RePLaCemExINTERFACENAME",$_[2]) ;}) . "\n";
    } else {
        if( $self->{__wach_numvals} == 2 ) {
            
        }
    
    }
    my 
    my $interfacename = $self->{__wach_ifacename};
    my $eventsubname = $self->{__wach_event_sub}
    $code =~ s/RePLaCemExINTERFACENAME/$interfacename/g;
    $code =~ s/RePLaCemExEVENTSUBNAME/$eventsubname/g;
    return $code;
}

sub event_id_name {
    my $self = shift;
    return '' if 
    return 'EVENT_ID_AX_' . ${$self->{__wach_prefix_ref}} . '_' . $self->{__wach_event_sub};
}

sub event_id_code {
    my $self = shift;
    
}

package Wx::ActiveX::Control::Helper::BaseEvent;
use strict;
use base qw( Exporter );

sub new {
    my ($class, $ifacename, $prefixref, $exportref ) = shift;
    my $self = bless {}, $class;




1;
