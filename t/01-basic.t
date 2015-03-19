use v6;
use strict;

use Test;

use Linux::Fuser;

my $obj;



ok(Linux::Fuser.^can('fuser'), "Linux::Fuser can 'fuser()'");

lives_ok { $obj = Linux::Fuser.new() }, "create a new Linux::Fuser";

ok($obj.isa(Linux::Fuser), "and it's the right kind of object");

my $filename = $*PID ~ '.tmp';

my $fh = open "$*PID.tmp", :w;

my @procs;

lives_ok { @procs = $obj.fuser($filename) }, "fuser() doesn't die";

ok(@procs.elems, "got some processes");
ok(my $proc = @procs[0], "get the first");

ok($proc ~~ Linux::Fuser::Procinfo, "And it's the right kind of object");
is($proc.pid, $*PID, "got the expected PID");
ok($proc.cmd.elems, "got some command line");

$filename.IO.remove;

done;

