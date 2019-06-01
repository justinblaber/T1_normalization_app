# NOTE: Derived from blib/lib/MNI/MiscUtilities.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package MNI::MiscUtilities;

#line 92 "blib/lib/MNI/MiscUtilities.pm (autosplit into blib/lib/auto/MNI/MiscUtilities/timestamp.al)"
#
# IDEA: should timestamp and userstamp be moved to a new module, say
# MNI::Footprint (should only be needed by Spawn, Backgroundify, and 
# MINC history stuff)?
#

# ------------------------------ MNI Header ----------------------------------
#@NAME       : timestamp
#@INPUT      : $tm - [optional] time to use, as seconds since 
#                    1970-01-01 00:00:00 UTC (eg from `time'); 
#                    defaults to the current time
#@OUTPUT     : 
#@RETURNS    : 
#@DESCRIPTION: Generates and returns a timestamp of the form 
#              "1995-05-16 22:30:14".
#@METHOD     : 
#@GLOBALS    : 
#@CALLS      : 
#@CREATED    : 1995/05/16, GW (from &doit)
#@MODIFIED   : 1996/05/22, GW: added seconds to time
#              1996/06/17, GW: changed to use strftime from POSIX
#              1997/04/24, GW: copied from misc_utilities.pl, removed brackets
#-----------------------------------------------------------------------------
sub timestamp #(;$)
{
   my ($tm) = @_;

   $tm = time unless defined $tm;
   strftime ('%Y-%m-%d %H:%M:%S', localtime ($tm));
}

# end of MNI::MiscUtilities::timestamp
1;
