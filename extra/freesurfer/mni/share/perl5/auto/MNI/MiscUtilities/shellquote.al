# NOTE: Derived from blib/lib/MNI/MiscUtilities.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package MNI::MiscUtilities;

#line 369 "blib/lib/MNI/MiscUtilities.pm (autosplit into blib/lib/auto/MNI/MiscUtilities/shellquote.al)"
# ------------------------------ MNI Header ----------------------------------
#@NAME       : &shellquote
#@INPUT      : @words - list of words to possibly quote or escape
#@OUTPUT     : 
#@RETURNS    : concatenation of @words with necessary quotes and backslashes
#@DESCRIPTION: The inverse of shellwords -- takes a list of arguments 
#              (like @ARGV, or a list passed to system or exec) and 
#              escapes meta-characters or encases in quotes as appropriate
#              to allow later processing by the shell.  (/bin/sh, in 
#              particular -- the list of metacharacters was taken from
#              the Perl source that does an exec().)
#@METHOD     : If a word contains no metacharacters and is not empty, it is
#              untouched.  If it contains both single and double quotes,
#              all meta- characters are escaped with a backslash, and no
#              quotes are added.  If it contains just single quotes, it is
#              encased in double quotes.  Otherwise, it is encased in
#              single quotes.
#@GLOBALS    : 
#@CALLS      : 
#@CREATED    : 1996/11/13, Greg Ward
#@MODIFIED   : 
#-----------------------------------------------------------------------------
sub shellquote
{
   my (@words) = @_;
   
   local $_;
   for (@words)
   {
      # This list of shell metacharacters was taken from the Perl source
      # (do_exec(), in doio.c).  It is, in slightly more readable form:
      # 
      #    $ & * ( ) { } [ ] ' " ; \ | ? < > ~ ` \n
      #
      # (plus whitespace).  This totally screws up cperl-mode's idea of
      # the syntax, unfortunately, so don't expect indenting to work
      # at all in the rest of this function.

      if ($_ eq "" || /[\s\$\&\*\(\)\{\}\[\]\'\";\\\|\?<>~`\n]/)
      {
         # If the word has both " and ' in it, then just backslash all 
         #   metacharacters;
         # if it has just ' then encase it in "";
         # otherwise encase it in ''

         SUBST:
         {
            (s/([\s\$\&\*\(\)\{\}\[\]\'\";\\\|\?<>~`\n])/\\$1/g, last SUBST)
               if (/\"/) && (/\'/);
            ($_ = qq/"$_"/, last SUBST) if (/\'/);
            $_ = qq/'$_'/;
         }
      }
   }

   join (" ", @words);
}

1;
1;
# end of MNI::MiscUtilities::shellquote
