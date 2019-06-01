# NOTE: Derived from blib/lib/MNI/PathUtilities.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package MNI::PathUtilities;

#line 537 "blib/lib/MNI/PathUtilities.pm (autosplit into blib/lib/auto/MNI/PathUtilities/expand_path.al)"
my $dir_cache;

# ------------------------------ MNI Header ----------------------------------
#@NAME       : &expand_path
#@INPUT      : $path
#@OUTPUT     : 
#@RETURNS    : $path, with ~name and $var expanded
#@DESCRIPTION: Expands usernames and environment variables in a path.
#@CREATED    : 1997/07/29, GPW
#@MODIFIED   : 
#-----------------------------------------------------------------------------
sub expand_path
{
   my ($path) = @_;
   my ($homedir, $username);

   if ($path =~ s|^~([^/]*)||)          # starts with a twiddle
   {
      $username = $1;
      if ($username eq '')              # empty string -- current user
      {
         $path = $ENV{'HOME'} . $path;
      }
      else                              # some other user
      {
         unless (defined $dir_cache)
         {
            my (@pwent);
            $dir_cache->{$pwent[0]} = $pwent[7]
               while (@pwent = getpwent);
            endpwent;
         }

         unless (exists $dir_cache->{$username})
         {
            warn "unknown username \"$username\"\n";
            return 0;
         }

         $path = $dir_cache->{$username} . $path;
      }
   }

   # and now expand any environment variables in $path

   while ($path =~ s|\$(\w+)|$ENV{$1}|e)
   {
      unless (exists $ENV{$1})
      {
         warn "unknown environment variable \"$1\"\n";
         return 0;
      }
   }

   return $path;

}  # expand_path

1;
1;
# end of MNI::PathUtilities::expand_path
