# EXPANSION
export TEST=LOL
echo "$?TEST"
echo $TEST
echo "$TEST"
echo '$TEST'
echo "$TEST$TEST$TEST"
echo "   $TEST lol $TEST"
echo test "" test "" test
echo "\$TEST"
echo "$=TEST"
echo $TEST $TEST
echo "$1TEST"
echo "$T1TEST"

# COMMANDS
export LS="ls"
echo "$LS"
$LS

export LS="ls      -a"
echo "$LS"
$LS
