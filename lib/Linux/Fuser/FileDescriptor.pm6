class Linux::Fuser::FileDescriptor {

   has Int $.fd;
   has Int $.pos;
   has Int $.mnt_id;
   has Int $.flags;
   has IO::Path $.proc_file;
   has IO::Path $.fd_file;
   has IO::Path $.fd_info;

   submethod BUILD(:$!proc_file, :$!fd_file) {
      $!fd = $!fd_file.basename.Int;
      $!fd_info = $!proc_file.append('fdinfo', $!fd);
      my %info = open($!fd_info.Str, :bin).read(255).decode.lines.map( { $_.split(/\:\t/) }).hash
   }
}
