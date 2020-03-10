# MINISHELL-TESTER

# Compile and set executable rights
make re -C ../ > /dev/null
cp ../minishell .
chmod 755 minishell

# Clean and create files
rm -rf errors.txt errors2.txt
touch errors.txt output expected_output

function get_prompt()
{
	PROMPT=$(echo | ./minishell 2>&1)
	# echo $PROMPT
}

function exec_test()
{
	TEST1=$(echo $@ | ./minishell 2>&-)
	ES_1=$?
	TEST2=$(echo $@ | bash 2>&-)
	ES_2=$?
	if [ "$TEST1" == "$TEST2" ]; then
		printf "\033[0;32m[OK]\033[0m "
	else
		printf "\033[0;31m[KO]\033[0m "
		echo "$@ :" >> errors.txt
		echo "You should have returned \"$TEST2\" instead of \"$TEST1\"" >> errors.txt
		echo >> errors.txt
	fi
}

function exec_test_error()
{
	TEST1=$(echo $@ | ./minishell 2>&1)
	ES_1=$?
	TEST2=$(echo $@ | bash 2>&1)
	ES_2=$?
	if [ "$TEST1" == "$TEST2" ]; then
		printf "\033[0;32m[OK]\033[0m "
	else
		printf "\033[0;31m[KO]\033[0m "
		echo "$@ :" >> errors.txt
		echo "You should have returned \"$TEST2\" instead of \"$TEST1\"" >> errors.txt
		echo >> errors.txt
	fi
}

function do_test_exit()
{
	echo $@ | ./minishell 2>&-
	ES_1=$?
	echo $@ | bash 2>&-
	ES_2=$?
	if [ "$ES_1" == "$ES_2" ]; then
		echo -e -n "\033[0;32m[OK]\033[0m"
	else
		echo -e -n "\033[0;31m[KO]\033[0m"
		printf "__________________________\n\n" >> errors.txt
		printf "ERRORS WITH 'exit' : \n\n" >> errors.txt
		printf "__________________________\n\n" >> errors.txt
		echo "You should have exited with $ES_2 instead of $ES_1" >> errors.txt
	fi
	echo -n " "
}
get_prompt

# # SYNTAX TESTS
# printf "%-20s" "syntax : "
# exec_test_error '> >'
# exec_test_error '<>'
# exec_test_error 'test |'
# exec_test_error '>> >'
# exec_test_error '>>>'
# exec_test_error ';; test'
# echo

# ECHO TESTS
printf "%-20s" "echo : "
exec_test 'echo test tout'
exec_test 'echo test      tout'
exec_test 'echo -n test tout'
exec_test 'echo -n -n -n test tout'
echo
echo

# CD TESTS
printf "%-20s" "cd : "
exec_test 'cd dgdgad'
exec_test 'cd .. ; pwd'
exec_test 'cd /Users ; pwd'
exec_test 'cd /Users ; pwd'
exec_test 'cd ; pwd'
exec_test 'mkdir test_dir ; cd test_dir ; rm -rf ../test_dir ; cd . ; pwd ; cd . ; pwd ; cd .. ; pwd'
echo
echo

# PIPE TESTS
printf "%-20s" "pipes : "
exec_test 'cat tests/lorem.txt | grep arcu | cat -e'
exec_test 'ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls|ls'
echo
echo

# ENV EXPANSIONS
printf "%-20s" "env expansions : "
exec_test 'echo $TEST'
exec_test 'echo "$TEST"'
exec_test "echo '$TEST'"
exec_test 'echo "$TEST$TEST$TEST"'
exec_test 'echo "$TEST$TEST=lol$TEST"'
exec_test 'echo "   $TEST lol $TEST"'
exec_test 'echo test "" test "" test'
exec_test 'echo "\$TEST"'
exec_test 'echo "$=TEST"'
exec_test 'echo "$?TEST"'
exec_test 'echo $TEST $TEST'
exec_test 'echo "$1TEST"'
exec_test 'echo "$T1TEST"'
echo
echo

# MULTI TESTS
printf "%-20s" "multi : "
exec_test 'echo testing multi ; echo "test 1 ; | and 2" ; cat tests/lorem.txt | grep Lorem'
echo
echo


# Exits tests :)
printf "%-20s" "exit : "
do_test_exit "exit 42"
do_test_exit "exit 42 53 68"
do_test_exit "exit 259"
do_test_exit "exit -4"
do_test_exit "exit wrong"
do_test_exit "wrong_command ; exit"
do_test_exit "ls -la | wtf ; exit"
echo

# rm -rf output expected_output
