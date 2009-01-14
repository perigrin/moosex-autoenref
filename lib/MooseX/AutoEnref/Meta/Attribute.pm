package MooseX::AutoEnref::Meta::Attribute;
use Moose;
extends qw(Moose::Meta::Attribute);

around 'set_value' => sub {
    my ( $next, $self, @args ) = @_;

    if ( $self->should_auto_enref ) {
        my $type_constraint = $self->type_constraint;
        if ( $type_constraint->is_a_type_of('ArrayRef') ) {
            return $self->$next( [@args] );
        }
        elsif ( $type_constraint->is_a_type_of('HashRef') ) {
            return $self->$next( {@args} );
        }
    }

    return $self->$next(@args);
};

