bing_rewards
============

Script to earn maximum points for searching from Bing

Bing's Reward program: http://www.bing.com/explore/rewards?PUBL=REFERAFRIEND&CREA=RAW&rrid=_42d28ca0-cfe9-6924-c421-81d97e7fde47

So Bing will let you earn points in exchange for your exploring their new(?) page. This script assumes you have an account with Microsoft already to login with.

This script will:
- auto log you in
- generate 30 terms to query
- auto search 30x
- quit when finished

## Getting Started

`$ gem install watir-webdriver`

Replace `BING_USERNAME` with your login

Replace `BING_PASSWORD` with your password

`$ ruby run.rb`
