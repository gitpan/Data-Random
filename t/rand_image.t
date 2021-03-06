use strict;
use Test::More;

BEGIN { plan tests => 1 }

use lib qw(..);
use Data::Random qw( rand_image );
use File::Spec;

use vars qw( $imagefile );

# Try to load GD
eval q{ use GD };

SKIP: {

    # If the module cannot be loaded, skip tests
    skip('GD not installed', 1) if $@;

    $imagefile = File::Spec->tmpdir() . '/Data_Random_' . time() . '.tmp';

    # Test writing an image to a file
    {
        open( FILE, ">$imagefile" );
        binmode(FILE);
        print FILE rand_image( bgcolor => [ 0, 0, 0 ] );
        close(FILE);

        ok( !( -z $imagefile ) );
    }
}

END {
    unlink($imagefile) if $imagefile;
}
