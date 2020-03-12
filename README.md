# MINISHELL-TESTER

## Requirements

- You must have your prompt and any other message/banner printed on ``STDERR`` (like bash)
- Your minishell must exit when an EOF is received by your ``read`` inside your program (the CTRL-D part)

## Usage

1. Go into your minishell folder and clone this repo
2. Run ``cd minishell-tester && bash test.sh``
3. You can see your errors in ``errors.txt``

## What does it test ?

- ``echo``
- ``cd``
- ``pwd``
- ``exit``
- ``| pipes``
- ``; separator``
- ``env expansions``
- ``export``
- ``env``
- ``unset``
- ``exit status ($?)``

## What should I test by myself ?

Almost everything :) This tester is not perfect and is not checking ``leaks`` and ``error messages``.<br>
It's there to show you a few errors that can occurs.
You should do some tests on your own aswell !

Feel free to improve this tester !
