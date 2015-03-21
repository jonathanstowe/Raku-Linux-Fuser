class Linux::Fuser::FileDescriptor {

   #|The file descriptor number
   has Int $.fd;
   #|The position in the file the opening process has the file pointer
   has Int $.pos;
   #|mnt_id
   has Int $.mnt_id;
   #|The flags with which the file was opened
   has Int $.flags;
   has IO::Path $.proc_file;
   has IO::Path $.fd_file;
   has IO::Path $.fd_info;

   submethod BUILD(:$!proc_file, :$!fd_file) {
      $!fd = $!fd_file.basename.Int;
      $!fd_info = $!proc_file.append('fdinfo', $!fd);
      my %info = open($!fd_info.Str, :bin).read(255).decode.lines.map( { $_.split(/\:\t/) }).hash;
      $!pos = %info<pos>.Int;
      $!mnt_id = %info<mnt_id>.Int;
      my $str_fl = %info<flags>;
      # This seems like a really crap way of doing it
      $str_fl ~~ s/^0/0o/;
      $!flags = $str_fl.Int;
   }
}
