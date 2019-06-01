# NOTE: Derived from blib/lib/MNI/NumericUtilities.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package MNI::NumericUtilities;

#line 120 "blib/lib/MNI/NumericUtilities.pm (autosplit into blib/lib/auto/MNI/NumericUtilities/labs.al)"
# ------------------------------ MNI Header ----------------------------------
#@NAME       : &labs
#@INPUT      : 
#@OUTPUT     : 
#@RETURNS    : 
#@DESCRIPTION: Returns the absolute value of its argument(s).  In an array
#              context, returns a list of absolute values, otherwise just
#              a scalar.
#@METHOD     : 
#@GLOBALS    : 
#@CALLS      : 
#@CREATED    : 95/04/12, GW
#@MODIFIED   : 95/09/01, GW: fixed so it doesn't modify its arguments (dohh!)
#              97/04/11, GW: renamed to labs (list absolute value), and
#                            made it call Perl's builtin abs function
#@COMMENTS   : You might think this was obsolete with Perl 5, but
#              the Perl 5 builtin only takes a scalar -- this version
#              will take and return a list if desired.
#-----------------------------------------------------------------------------
sub labs
{
   my (@nums) = @_;

   foreach (@nums)
   {
      $_ = abs $_;
   }
   wantarray ? @nums : $nums[0];
}

# end of MNI::NumericUtilities::labs
1;
