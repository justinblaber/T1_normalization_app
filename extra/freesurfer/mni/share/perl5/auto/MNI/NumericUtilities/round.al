# NOTE: Derived from blib/lib/MNI/NumericUtilities.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package MNI::NumericUtilities;

#line 169 "blib/lib/MNI/NumericUtilities.pm (autosplit into blib/lib/auto/MNI/NumericUtilities/round.al)"
# ------------------------------ MNI Header ----------------------------------
#@NAME       : &round
#@INPUT      : $value - number to round
#              $factor - what to round to; eg. 1 to round to an integer,
#                        .5 to round to a half-integer, or 10 to a
#                        factor of 10.
#              $direction - 0 to round to nearest $factor
#                          -1 to round down to next $factor
#                          +1 to round up to next $factor
#@OUTPUT     : 
#@RETURNS    : 
#@DESCRIPTION: Round off a number to a factor of
#              $factor, where $factor is the first argument.  Round either
#              to the nearest factor, or down, or up, depending on the value
#              of $direction.
#@METHOD     : 
#@GLOBALS    : 
#@CALLS      : 
#@CREATED    : 95/05/03, Greg Ward (hacked from Alex Zijdenbos' code)
#@MODIFIED   : 95/08/07, GW: added $direction
#              96/10/21, GW: changed "0" to "0.0" in comparison (!?!??!!!?)
#-----------------------------------------------------------------------------
sub round
{
   my($value, $factor, $direction) = @_;
   $factor = 1 unless defined $factor;
   $direction = 0 unless defined $direction;

   $factor = abs ($factor);
   $value /= $factor;
   if ($direction == 0)
   {
      $value += ($value < 0.0) ? (-0.5) : (+0.5);
      $value = int($value) * $factor;
   }
   elsif ($direction == -1)
   {
      $value = floor ($value) * $factor;
   }
   elsif ($direction == +1)
   {
      $value = ceil ($value) * $factor;
   }
}

1;
1;
# end of MNI::NumericUtilities::round
