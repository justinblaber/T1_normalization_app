# NOTE: Derived from blib/lib/MNI/MiscUtilities.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package MNI::MiscUtilities;

#line 307 "blib/lib/MNI/MiscUtilities.pm (autosplit into blib/lib/auto/MNI/MiscUtilities/make_banner.al)"
# ------------------------------ MNI Header ----------------------------------
#@NAME       : make_banner
#@INPUT      : $msg    - the string to print
#              $char   - the character to use when making the "banner"
#                        (optional; defaults to "-")
#              $width  - the width of field to pad to (optional; defaults
#                        to 80, but should default to width of terminal)
#@OUTPUT     : 
#@RETURNS    : 
#@DESCRIPTION: Creates and returns a string of the form 
#              "-- Hello! ----------" (assuming $msg="Hello!", $char="-", 
#              and $width=20)
#@METHOD     : 
#@GLOBALS    : 
#@CALLS      : 
#@CREATED    : 1996/05/22, Greg Ward - adapted from do_mritopet
#@MODIFIED   : 
#-----------------------------------------------------------------------------
sub make_banner
{
   my ($msg, $char, $width) = @_;

   $width = 80 unless $width;           # should this use Term::Cap?!?
   $char = "-" unless $char;

   my $banner = $char x 2 . " " . $msg . " ";
   $banner .= $char x ($width - length ($banner)) . "\n"
}

# end of MNI::MiscUtilities::make_banner
1;
