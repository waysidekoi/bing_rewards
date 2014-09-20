bing_rewards
============

Script to earn maximum points for searching from Bing

Bing's Reward program: http://www.bing.com/explore/rewards?PUBL=REFERAFRIEND&CREA=RAW&rrid=_42d28ca0-cfe9-6924-c421-81d97e7fde47

So Bing will let you earn points in exchange for your exploring their new(?) page. This script assumes you have an account with Microsoft already to login with.

This script will:
- auto log in
- calc n queries based on max earnable daily search points
- generate n terms to query
- exit if already reached max
- auto search, desktop and mobile
- auto collect "Earn X credits" rewards when available
- report when finished

## Getting Started

`$ bundle install`

Create a file called, `accts.json` with an array of hashes for
each username and password.  

``
[
  {"user":"USERNAME@DOMAIN.COM","pass":"PASSWORD"}
]
``

Execute script

`$ ./run`
