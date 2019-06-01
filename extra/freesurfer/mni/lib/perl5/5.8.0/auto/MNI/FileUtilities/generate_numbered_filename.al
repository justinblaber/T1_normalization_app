# NOTE: Derived from blib/lib/MNI/FileUtilities.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package MNI::FileUtilities;

#line 1054 "blib/lib/MNI/FileUtilities.pm (autosplit into blib/lib/auto/MNI/FileUtilities/generate_numbered_filename.al)"
# ------------------------------ MNI Header ----------------------------------
#@NAME       : &generate_numbered_filename
#@INPUT      : $base - first part of filename
#              $ext  - last part of filename (including "." if wanted)
#              $add_date - flag: if true, will add "_yyyy_mm_dd" after base
#@OUTPUT     : 
#@RETURNS    : Empty string on error (conflicting filenames or error 
#              renaming); otherwise, next filename in numbered sequence
#              starting with $base.
#@DESCRIPTION: Generates a numbered filename by incrementing a counter
#              $i until ${base}_${i}${ext} is found not to exist.  If
#              $i is 1 -- i.e. there weren't any files named with $base
#              and $ext -- then "_$i" is left out of the filename entirely.
#
#              For example, if called with $base="foo" and $ext=".log", and
#              neither "foo.log" nor "foo_1.log" exist, returns "foo.log".
#              On the next call, "foo.log" will be renamed to "foo_1.log",
#              and "foo_2.log" is returned.  Subsequent calls return
#              "foo_3.log", "foo_4.log", etc.  If both "foo.log" and
#              "foo_1.log" exist, then we print a warning and return the
#              empty string -- you'll have to deal with this degenerate
#              situation yourself, because it should never arise if you
#              only use &generate_numbered_filename to generate filenames.
#@METHOD     : 
#@GLOBALS    : 
#@CALLS      : 
#@CREATED    : 1996/08/01, GPW, from code in ICBM.pm
#@MODIFIED   : 
#-----------------------------------------------------------------------------
sub generate_numbered_filename
{
   my ($base, $ext, $add_date) = @_;
   my $i = 1;

   $base .= strftime ("_%Y-%m-%d", localtime (time))
      if $add_date;

   if (-e "${base}${ext}")
   {
      if (-e "${base}_1${ext}")
      {
	 die "conflicting filenames: ${base}${ext} and ${base}_1${ext}\n";
      }
      else
      {
	 rename ("${base}${ext}", "${base}_1${ext}") ||
            die ("unable to rename ${base}${ext}: $!\n");
      }
   }

   $i++ while (-e "${base}_${i}${ext}");
   ($i == 1) ? "${base}${ext}" : "${base}_${i}${ext}";
}

# end of MNI::FileUtilities::generate_numbered_filename
1;
