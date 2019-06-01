# NOTE: Derived from blib/lib/MNI/FileUtilities.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package MNI::FileUtilities;

#line 1125 "blib/lib/MNI/FileUtilities.pm (autosplit into blib/lib/auto/MNI/FileUtilities/statfs.al)"
# ------------------------------ MNI Header ----------------------------------
#@NAME       : &statfs
#@INPUT      : 
#@OUTPUT     : 
#@RETURNS    : list of useful-sounding values that are common to IRIX 
#              and Linux:
#                 $type    - filesystem (see your header files for definitions)
#                 $bsize   - block size (in bytes)
#                 $blocks  - total number of blocks in filesystem
#                 $bfree   - free blocks in filesystem (under Linux, this
#                            will be the "available block" count -- ie.
#                            number of blocks available to non-superuser)
#                 $files   - number of file nodes
#                 $ffree   - number of available file nodes
#@DESCRIPTION: Attempts to call the statfs(2) system call.  Will only 
#              work on Linux/i86 or IRIX.
#@METHOD     : 
#@GLOBALS    : 
#@CALLS      : 
#@CREATED    : 1997/03/06, GPW
#@MODIFIED   : 
#@COMMENTS   : there is a File::statfs (or maybe Filesystem::stat?) module
#              mentioned in the module list, but no sign of it on CPAN.  Hmmm.
#-----------------------------------------------------------------------------
sub statfs
{
   require 5.003;                       # for $^O

   my ($path) = @_;
   my ($buf, $r);
   my ($type, $pad, $bsize, $frsize, $blocks, $bfree, $bavail);
   my ($files, $ffree, $fsid, $namelen, $spare, $fname, $fpack);

   if ($^O eq 'linux')
   {
      # structure size taken from i86 Linux 2.0 man pages; only tested
      # on Linux 2.0/i86 

      require "syscall.ph";
      $buf = ' ' x ( (7 + 2 + 1 + 6) * 4);
      $r = syscall (&SYS_statfs, $path, $buf);
      ($type,$bsize,$blocks,$bfree,$bavail,$files,$ffree,$fsid,$namelen,$spare)
         = unpack ("lllllll2ll6", $buf);
      $bfree = $bavail;         # ignore the free/available distinction (RTFM)
   }
   elsif ($^O eq 'irix')
   {
      my $len = (2 +2 + (6 * 4) + 6 + 6);
      $buf = ' ' x $len;
      $r = syscall (1035, $path, $buf, $len, 0);
      ($type,$pad,$bsize,$frsize,$blocks,$bfree,$files,$ffree,$fname,$fpack)
         = unpack ("ssllllllc6c6", $buf);
   }
   else
   {
      die "Sorry, I don't know how to do `statfs' under $^O\n";
   }

   if ($r == 0)                         # success?
   {
      return ($type, $bsize, $blocks, $bfree, $files, $ffree);
   }
   else                                 # failure
   {
      warn "statfs failed on \"$path\": $!\n";
      return;
   }
}

1;
1;
# end of MNI::FileUtilities::statfs
