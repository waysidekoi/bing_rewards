#!/usr/bin/env ruby
require 'watir-webdriver'

BING_USERNAME = ''
BING_PASSWORD = ''

b = Watir::Browser.new :firefox

# get top trends from google
b.goto "http://www.google.com/trends/hottrends"

# Load more results on the page
1.times do
  bb = b.div id: "more-link"
  until bb.exists?
    sleep(1)
    bb = b.div id: "more-link"
  end
  bb.click
end

# get keywords
# DOM element: span 'hottrends-single-trend-title'
s = b.spans class: "hottrends-single-trend-title"
keywords = s.map { |span| span.text.gsub(/\s/,'+') }

# login
b.goto "https://login.live.com/login.srf?wa=wsignin1.0&rpsnv=12&ct=1393221381&rver=6.0.5286.0&wp=MBI&wreply=http:%2F%2Fwww.bing.com%2FPassport.aspx%3Frequrl%3Dhttp%253a%252f%252fwww.bing.com%252f&lc=1033&id=264960"

user = b.text_field id: "i0116"
user.set BING_USERNAME

pass = b.text_field id: "i0118"
pass.set BING_PASSWORD

submit = b.input type: "submit"
submit.click

# break on bad login/pass
if b.alert.exists?
  # get through dialog
  b.alert.ok

  # update cookie
  b.goto "bing.com"
else
  user_error = b.div id: "idTd_PWD_ErrorMsg_Username"
  pass_error = b.div id: "idTd_PWD_Error_Password"

  if user_error.present? || pass_error.present?
    b.close
    puts "Bad login/pass! Aborting"
    abort
  end
end


# check if logged in
retries = 0
el = b.span id: "id_rc"
points_start = el.text

while points_start == "0 of 5" && retries <= 5
  retries++
  sleep(5)
  b.goto "bing.com"
  el = b.span id: "id_rc"
  points_start = el.text
end

if retries == 5
  b.close
  puts "Unable to receive login from Bing after #{retries} attempts"
  abort
else
  # search 30x
  keywords.first(30).each do |key|
    b.goto "bing.com/search?q=#{key}"
  end
  b.close
  puts "Done!"
end
