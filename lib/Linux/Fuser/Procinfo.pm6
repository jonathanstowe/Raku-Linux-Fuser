use Linux::Fuser::FileDescriptor;

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
      my $cmd_fh = open($cmdline, :bin);
      @!cmd = $cmd_fh.read(4096).decode.split("\0");
   }

}
