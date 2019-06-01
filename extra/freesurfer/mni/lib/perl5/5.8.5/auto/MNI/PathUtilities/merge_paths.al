# NOTE: Derived from blib/lib/MNI/PathUtilities.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package MNI::PathUtilities;

#line 480 "blib/lib/MNI/PathUtilities.pm (autosplit into blib/lib/auto/MNI/PathUtilities/merge_paths.al)"
# ------------------------------ MNI Header ----------------------------------
#@NAME       : &merge_paths
#@INPUT      : a list of directories (well, they could almost be any strings,
#              except we tweak 'em a bit with the assumption that they are
#              directories for a PATH-like list)
#@OUTPUT     : 
#@RETURNS    : the input list, but with duplicates removed, trailing slashes
#              stripped, and empty strings converted to '.'
#@DESCRIPTION: 
#@METHOD     : 
#@GLOBALS    : 
#@CALLS      : 
#@CREATED    : 1995/12/04 GPW
#@MODIFIED   : 
#-----------------------------------------------------------------------------
sub merge_paths
{
   my (@dirs) = @_;
   my (%seen, $dir, @path);

   foreach $dir (@dirs)
   {
      $dir =~ s|/$|| unless $dir eq '/'; # strip trailing slash
      $dir = '.' unless $dir;           # ensure no empty strings
      push (@path, $dir) unless $seen{$dir};
      $seen{$dir} = 1;
   }
   @path;
}

# end of MNI::PathUtilities::merge_paths
1;
