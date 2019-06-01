# NOTE: Derived from blib/lib/MNI/NumericUtilities.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package MNI::NumericUtilities;

#line 79 "blib/lib/MNI/NumericUtilities.pm (autosplit into blib/lib/auto/MNI/NumericUtilities/in_range.al)"
# ------------------------------ MNI Header ----------------------------------
#@NAME       : in_range
#@INPUT      : $val - value to test
#              $lo  - lower bound
#              $hi  - upper bound
#@OUTPUT     : 
#@RETURNS    : 0 if $val is within the closed interval [$lo, $hi]
#              -1 if $val is less than $lo
#              +1 if $val is greater than $hi
#@DESCRIPTION: Tests whether a number is within a specified range.
#@METHOD     : 
#@GLOBALS    : 
#@CALLS      : 
#@CREATED    : 95/3/8, Greg Ward
#@MODIFIED   : 
#-----------------------------------------------------------------------------
sub in_range
{
   my ($val, $lo, $hi) = @_;

   croak "invalid range: LO must be less than or equal to HI" 
      unless $lo <= $hi;
   return (-1) if ($val < $lo);
   return (+1) if ($val > $hi);
   return (0);
}

# end of MNI::NumericUtilities::in_range
1;
