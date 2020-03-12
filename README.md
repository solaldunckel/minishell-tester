# MINISHELL-TESTER

## Requirements

- You must have your prompt and any other message/banner printed on ``STDERR`` (like bash)

## Usage

1. Go into your minishell folder and clone this repo
2. Run ``cd minishell-tester && bash test.sh``

## What does it test ?

- ``echo``
- ``cd``
- ``pwd``
- ``exit``
- ``| pipes``
- ``; separator``
- ``> >> < redirections``
- ``env expansions``
- ``export``
- ``env``
- ``unset``
- ``exit status ($?)``

## What should you test by yourself ?

Almost everything :) This tester is not perfect and is not checking ``leaks`` and ``error messages``.<br>
It's there to show you a few errors that can occurs.
You should do some tests on your own aswell !

Feel free to improve this tester !
