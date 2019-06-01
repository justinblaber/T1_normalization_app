# NOTE: Derived from blib/lib/MNI/FileUtilities.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package MNI::FileUtilities;

#line 473 "blib/lib/MNI/FileUtilities.pm (autosplit into blib/lib/auto/MNI/FileUtilities/check_input_dirs.al)"
# ------------------------------ MNI Header ----------------------------------
#@NAME       : check_input_dirs
#@INPUT      : @dirs - list of directories to check
#@OUTPUT     : 
#@RETURNS    : 1 if all directories exist and are readable
#              0 otherwise
#@DESCRIPTION: Checks to see if all desired input directories exist and
#              are readable and executable.  Prints meaningful error 
#              messages and returns false if anything is wrong.
#@METHOD     : 
#@GLOBALS    : 
#@CALLS      : 
#@CREATED    : 1995/05/02, Greg Ward
#@MODIFIED   : 1997/05/01, GW: added "-x" condition
#-----------------------------------------------------------------------------
sub check_input_dirs
{
   my (@dirs) = @_;
   my ($num_err) = 0;
   my $dir;

   foreach $dir (@dirs)
   {
      next unless $dir;                 # skip blank strings
      if (-e $dir || -l $dir)
      {
	 if (! -d $dir)
	 {
	    warn "$dir exists but is not a directory\n";
	    $num_err++;
	 }
	 elsif (! (-r $dir && -x $dir))
	 {
	    warn "$dir is a directory, but is not readable/searchable\n";
	    $num_err++;
	 }
      }
      else
      {
	 warn "directory $dir does not exist\n";
	 $num_err++;
      }
   }
   return ($num_err == 0);   
}

# end of MNI::FileUtilities::check_input_dirs
1;
