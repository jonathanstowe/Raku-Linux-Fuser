use IO::Path::More;

use Linux::Fuser::Procinfo;

=begin pod

=head1 NAME

Linux::Fuser - Determine which processes have a file open

=head1 SYNOPSIS

=begin code
  use Linux::Fuser;

  my $fuser = Linux::Fuser->new();

  my @procs = $fuser->fuser('foo');

  for @procs -> $proc ( @procs )
  {
    say $proc->pid(),"\t", $proc->user(),"\n",$proc->cmd();
  }
=end code

=head1 DESCRIPTION

This module provides information similar to the Unix command 'fuser' about
which processes have a particular file open.  The way that this works is
highly unlikely to work on any other OS other than Linux and even then it
may not work on other than 2.2.* kernels. Some features may not work
correctly on kernel versions older than 2.6.22

It should also be borne in mind that this may not produce entirely accurate
results unless you are running the program as the Superuser as the module
will require access to files in /proc that may only be readable by their
owner.


=cut

=end pod

class Linux::Fuser {


	multi method fuser (Str $file ) {
      self.fuser(IO::Path.new($file));
   }

   multi method fuser (IO::Path $file ) {
      my @procinfo;

      my $device = $file.device;
      my $inode  = $file.inode;

      for dir('/proc', test => /^\d+$/) -> $proc {
         try {
            for $proc.append('fd').dir(test => /^\d+$/) -> $fd {
               if ( self.same_file($file, $fd ) ) {
                  @procinfo.push(Linux::Fuser::Procinfo.new(proc_file => $proc, fd_file => $fd));
                  CATCH {
                     note $_;
                  }
               }
            }
         }
      }

      return @procinfo;
	}

   method same_file(IO::Path $left, IO::Path $right) {
      my Bool $rc = False;
      if ( ( $left.inode == $right.inode ) && ( $left.device == $right.device )) {
         $rc = True;
      }
      return $rc;
   }
	
}
