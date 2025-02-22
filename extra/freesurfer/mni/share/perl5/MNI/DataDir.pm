# ------------------------------ MNI Header ----------------------------------
#@NAME       : MNI::DataDir
#@DESCRIPTION: 
#@EXPORT     : 
#@EXPORT_OK  : 
#@EXPORT_TAGS: 
#@USES       : 
#@REQUIRES   : Common way for MNI packages to find a directory containing
#              static data (eg. model files).
#@CREATED    : 
#@MODIFIED   : 
#@VERSION    : $Id: DataDir.pm.in,v 1.6 1997/09/30 21:12:27 greg Rel $
#@COPYRIGHT  : Copyright (c) 1997 by Gregory P. Ward, McConnell Brain Imaging
#              Centre, Montreal Neurological Institute, McGill University.
#
#              This file is part of the MNI Perl Library.  It is free 
#              software, and may be distributed under the same terms
#              as Perl itself.
#-----------------------------------------------------------------------------

package MNI::DataDir;

require 5.002;
use strict;
use Carp;

use MNI::FileUtilities qw(search_directories check_files);
use MNI::PathUtilities qw(normalize_dirs);

=head1 NAME

MNI::DataDir - find directory containing static model data for a package

=head1 SYNOPSIS

   use MNI::DataDir;

   $data_dir = MNI::DataDir::dir ($package_name);
   MNI::DataDir::check_data ($data_dir, \@model_files);

   $install_dir = MNI::DataDir::install_dir ($package_name);

=head1 DESCRIPTION

F<MNI::DataDir> gives a standard method for applications to find static
data (such as model files), and a standard interface for users to
customize this search.  This is to ensure that all our software acts in
a consistent, predictable way.

From the programmer's perspective, using F<MNI::DataDir> is quite
simple: make a single call to C<MNI::DataDir::dir> early in your
program, and use the result from that to construct the names of all your
static data files.  You can also call C<MNI::DataDir::check_data> to
ensure that all required data files are present before proceeding.

For example, C<mritotal> (part of the MNI AutoReg package) depends on
several custom variations of the MNI Average Brain.  Assume that all
these files start with C<'average_305'>, and end with C<'_mask.mnc'>,
C<'_16_blur.mnc'>, etc.  Code to find the model directory would be:

   $ModelDir = MNI::DataDir::dir ('autoreg');

and to ensure that all the required model files are present:

   @files = ('average_305_mask.mnc',
             'average_305_16_blur.mnc',
             'average_305_8_blur.mnc',
             'average_305_8_dxyz.mnc');
   MNI::DataDir::check_data ($ModelDir, \@files);

(In reality, C<mritotal> allows a user-defined model, so the
C<'average_305'> string isn't fixed.  But that's not relevant here.)

From the user's perspective, things are equally simple: there is a
default directory hard-coded into F<MNI::DataDir>, which is selected by
the system administrator when the MNI Perl Library is built and
installed.  The hard-coded default for the version of F<MNI::DataDir>
that you're currently reading about is F</usr/pubsw/packages/mni/1.5/data>.

Normally, C<MNI::DataDir::dir> looks under this default directory for a
package-specific data directory---for instance, in the above example, it
would look for F</usr/pubsw/packages/mni/1.5/data/autoreg>.  If this directory isn't
found, C<MNI::DataDir::dir> will C<die>, crashing your program with an
appropriate error message for the end user.

However, the user may override this default directory by setting the
C<MNI_DATAPATH> environment variable.  This should be a colon-separated
list of directories, which will be searched in turn for the
package-specific directory.  If it is not found in any of the
explicitly-named directories, C<MNI::DataDir::dir> will C<die>.  It will
I<not> fallback to the default directory.

=cut

# Note that we check for the environment variable *only* here -- i.e.
# when the module is run, which happens at the program's compile-time.
# Thus, the program cannot override the default path by setting the
# environment variable before calling `dir'.  (Except by setting it in a
# BEGIN block before `use'ing MNI::DataDir.  But that would be very
# rude.)

my $default_dir = '/usr/pubsw/packages/mni/1.5/data';
my @search_path = exists $ENV{'MNI_DATAPATH'}
   ? split (':', $ENV{'MNI_DATAPATH'})
   : ($default_dir);
my $program_name = defined $::ProgramName ? $::ProgramName : $0;


=head1 SUBROUTINES

=over 4

=item dir (PACKAGE)

Searches for a directory named by PACKAGE, either in the directories
specified in the C<MNI_DATAPATH> environment variable, or in the
hard-coded default directory.  Returns the directory name in a form
suitable for immediate concatenation with filenames---i.e. with a
trailing slash.  Dies if the directory was not found.

=cut

sub dir
{
   my $package_name = shift
      or croak "MNI::DataDir::dir: \$package_name must be given";
   my $dir;

   croak "MNI::DataDir::dir: \$package_name must be given" 
      unless $package_name;

   unless ($dir = search_directories ($package_name, \@search_path, '-d'))
   {
      die "$program_name: data directory for package \"$package_name\" " .
          "not found in " . join (':', @search_path) . "\n";
   }
        
   return $dir . $package_name . '/';
}


=item install_dir (PACKAGE)

Similar to C<dir>, but C<install_dir> never fails; if it doesn't find a
directory for PACKAGE on its search path, it makes an educated guess at
what the package directory ought to be.  In particular, it takes the
first directory from the search path (which will just be the hard-coded
default directory, unless the MNI_DATAPATH environment variable is
defined) and appends PACKAGE to it.

This is meant to be used only at package-configuration time, to provide
the installer of the package with a reasonable default place to put the
package's data.

Note that C<install_dir> most expressly does I<not> create the directory
it comes up with.  For one thing, the installer ought to be able to
choose a different directory; this is just a reasonable initial guess.
For another thing, installation directories should only be created at
installation time, not at configuration time.

=cut

sub install_dir
{
   my $package_name = shift 
      or croak "MNI::DataDir::install_dir: \$package_name must be given";
   my $dir;

   $dir = search_directories ($package_name, \@search_path, '-d')
      || $search_path[0];
   normalize_dirs ($dir);
   $dir . $package_name . '/';
}


=item check_data (DIR, FILES)

Checks that each file named in FILES (a list ref) exists in DIR.  DIR
is presumably of the form returned by C<MNI::DataDir::dir>, i.e. with a
trailing slash.  Dies if any files do not exist or are not readable.

=cut

sub check_data
{
   my ($dir, $files) = @_;

   croak "MNI::DataDir::check_data: invalid data directory \"$dir\""
      unless -d $dir;
   croak "MNI::DataDir::check_data: \$files must be a list ref"
      unless ref $files eq 'ARRAY';
   my @files = map ($dir . $_, @$files);
   check_files (\@files) 
      || die "$program_name: some required data files not found in $dir\n";
}

=back

=head1 AUTHOR

Greg Ward, <greg@bic.mni.mcgill.ca>.

=head1 COPYRIGHT

Copyright (c) 1997 by Gregory P. Ward, McConnell Brain Imaging Centre,
Montreal Neurological Institute, McGill University.

This file is part of the MNI Perl Library.  It is free software, and may be
distributed under the same terms as Perl itself.

=cut

1;
