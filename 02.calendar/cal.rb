#!/usr/bin/env ruby
require 'optparse'
require 'date'

params = ARGV.getopts("m:","y:")
params["m"] = Date.today.mon if params["m"].nil?
params["y"] = Date.today.year if params["y"].nil?

puts "      #{params["m"]}月 #{params["y"]}"
puts "日 月 火 水 木 金 土"

first_day_of_month = Date.new(params["y"].to_i, params["m"].to_i)
last_day_of_month = Date.new(params["y"].to_i, params["m"].to_i, -1)

print "   " * first_day_of_month.wday

(first_day_of_month..last_day_of_month).each do |d|
  print "#{d.day.to_s.rjust(2)} "
  puts if d.saturday? || d == last_day_of_month
end

puts if last_day_of_month.wday == 6
