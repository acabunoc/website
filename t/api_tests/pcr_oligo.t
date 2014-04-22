#!/usr/bin/env perl

# Pcr_oligo class tests

{
    # Package name is the same as the filename (sans suffix, i.e. no .t ending)
    package pcr_oligo;

    # Limit the use of unsafe Perl constructs.
    use strict;

    # We use Test::More for all tests, so include that here.
    use Test::More;

    # This variable will hold a reference to a WormBase API object.
    my $api;

    # A setter method for passing on a WormBase API object from t/api.t to
    # the subs of this package.
    sub config {
        $api = $_[0];
    }

    # test on_orfeome_project method - make sure it's really empty
    sub test_on_orfeome_project {
        my $pcr = $api->fetch({ class => 'Pcr_oligo', name => 'sjj_F32E10.3' });

        can_ok('WormBase::API::Object::Pcr_oligo', ('on_orfeome_project'));

        my $orfeome = $pcr->on_orfeome_project();

        is  ($orfeome->{'data'}, undef, 'data correctly empty');
    }

    # test overlaps_pseudogene method - don't return a reference
    sub test_overlap_pseudogene {
        my $pcr = $api->fetch({ class=> 'Pcr_oligo', name => 'sjj_F29C4.5' });

        can_ok('WormBase::API::Object::Pcr_oligo', ('overlaps_pseudogene'));

        my $pseudogene = $pcr->overlaps_pseudogene();

        isnt($pseudogene->{'data'}, undef, 'data returned');
        is  ($pseudogene->{'data'}[0]{'id'}, 'F29C4.5', 'correct pseudogene returned');
    }

    # test overlaps_variation method
    sub test_overlaps_variation {
        my $pcr = $api->fetch({ class=> 'Pcr_oligo', name => '171720_x_at' });

        can_ok('WormBase::API::Object::Pcr_oligo', ('overlaps_variation'));

        my $variation = $pcr->overlaps_variation();

        is ($variation->{'data'}, undef, 'data correctly empty');
    }

}

1;

