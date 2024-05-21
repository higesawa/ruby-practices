#!/usr/bin/env ruby
require 'optparse'
require 'date'

# 引数からの入力を取得
params = ARGV.getopts("m:","y:")

# 引数が存在しない場合、今月・今年が指定される
if params["m"] == nil && params["y"] == nil
  params["m"] = Date.today.mon
  params["y"] = Date.today.year
end

# 年月の表示
puts "      #{params["m"]}月 #{params["y"]}"

# 曜日表示
puts "日 月 火 水 木 金 土"

## calendarの該当月の日数を取得
first_day_of_month = Date.new(params["y"].to_i, params["m"].to_i)
last_day_of_month = Date.new(params["y"].to_i, params["m"].to_i + 1) - 1

# 該当月の1日の曜日に合わせてスペースをいれる
print "   " * first_day_of_month.wday

# 土曜日となる日付で改行して表示
# 月の最終日を print で出力すると % が表示されてしまう問題を解消
(first_day_of_month..last_day_of_month).each do |d|
  if d.saturday?
    puts "%2d" %"#{d.day}" + " "
  elsif d == last_day_of_month
    puts "%2d" %"#{d.day}" + " "
  else
    print "%2d" %"#{d.day}" + " "
  end
end

# 月の最終日が土曜だった場合、空行を入れる
puts " " if last_day_of_month.wday == 6
