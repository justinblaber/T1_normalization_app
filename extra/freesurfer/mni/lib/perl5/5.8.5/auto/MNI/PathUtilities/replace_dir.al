# NOTE: Derived from blib/lib/MNI/PathUtilities.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package MNI::PathUtilities;

#line 388 "blib/lib/MNI/PathUtilities.pm (autosplit into blib/lib/auto/MNI/PathUtilities/replace_dir.al)"
# ------------------------------ MNI Header ----------------------------------
#@NAME       : replace_dir
#@INPUT      : $newpath - directory to replace existing directories with
#              @files   - list of files to have directories replaced
#@OUTPUT     : 
#@RETURNS    : 
#@DESCRIPTION: Replaces the directory component of a list of pathnames.
#              Returns the list of files with substitutions performed.
#@METHOD     : 
#@GLOBALS    : 
#@CALLS      : 
#@CREATED    : 1995/05/04, Greg Ward
#@MODIFIED   : 1995/05/23, GW: renamed to &ReplaceDir
#-----------------------------------------------------------------------------
sub replace_dir
{
   my ($newpath, @files) = @_;

   normalize_dirs ($newpath);
   foreach (@files)
   {
      # Try to substitute an existing directory (ie. eat greedily up to
      # a slash) with the new directory.  If that fails, then there's no
      # slash in the filename, so just jam the new directory on the front.

      s|.*/|$newpath| 
         or $_ = $newpath . $_;
   }
   wantarray ? @files : $files[0];
}

# end of MNI::PathUtilities::replace_dir
1;
