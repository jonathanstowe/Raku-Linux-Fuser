use Linux::Fuser::FileDescriptor;
# For the time being
use System::Passwd;

class Linux::Fuser::Procinfo {
   has Int $.pid;
   has Str $.user;
   has Str @.cmd;
   has Linux::Fuser::FileDescriptor $.filedes;
   has IO::Path $.proc_file;
   has IO::Path $.fd_file;

   submethod BUILD(:$!proc_file, :$!fd_file) {
      $!pid = $!proc_file.basename + 0;
      my $cmdline = $!proc_file.append('cmdline').Str;
      # rather awkward locution but basically cmdline is a copy of the argv
      # as got to execve with the \0s and everything
      my $cmd_fh = open($cmdline, :bin);
      @!cmd = $cmd_fh.read(4096).decode.split("\0");
      $!filedes = Linux::Fuser::FileDescriptor.new(proc_file => $!proc_file, fd_file => $!fd_file);

      if ((my $uid = self!lstat_uid()).defined )
      {
         $!user = get_user_by_uid($uid).username;
      }

   }

   #| supply the required missing part of lstat() to get the owner of the FD
   method !lstat_uid() {
      nqp::p6box_i(nqp::stat(nqp::unbox_s($!fd_file.Str), nqp::const::STAT_UID));
   }

}
