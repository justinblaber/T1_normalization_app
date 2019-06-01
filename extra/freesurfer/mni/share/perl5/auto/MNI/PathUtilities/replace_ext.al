# NOTE: Derived from blib/lib/MNI/PathUtilities.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package MNI::PathUtilities;

#line 440 "blib/lib/MNI/PathUtilities.pm (autosplit into blib/lib/auto/MNI/PathUtilities/replace_ext.al)"
# ------------------------------ MNI Header ----------------------------------
#@NAME       : replace_ext
#@INPUT      : $newext  - extension to replace existing extensions with
#              @files   - list of files to have extensions replaced
#@OUTPUT     : 
#@RETURNS    : 
#@DESCRIPTION: Replaces the final extension (whatever follows the final dot)
#              of a list of pathnames.  Returns the list of files with
#              substitutions performed in array context, or the first filename
#              from the list in a scalar context.
#@METHOD     : 
#@GLOBALS    : 
#@CALLS      : 
#@CREATED    : 1995/05/23, Greg Ward (from &ReplaceDir)
#@MODIFIED   : 
#-----------------------------------------------------------------------------
sub replace_ext
{
   my ($newext, @files) = @_;

   foreach (@files)
   {
      s/\.[^\.]*$/\.$newext/;           # replace existing extension
   }
   wantarray ? @files : $files[0];
}

# end of MNI::PathUtilities::replace_ext
1;
