#!perl -w

$dir=`dir /b ..\\inp`;

@dir=split /\n/,$dir;
chomp @dir;
@dir=sort @dir;

$rez=".TestNumbers";
foreach $line (@dir){
   $line =~ s/.*?(\d+).*/$1/;
   $rez.=" $line";
}
open STDOUT,">.TestNumbers";
print "$rez\n";
close STDOUT;
