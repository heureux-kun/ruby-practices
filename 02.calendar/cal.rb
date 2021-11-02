#!/usr/bin/env ruby

require 'optparse'
require 'date'

opt = OptionParser.new
opt.on('-y')
opt.on('-m')
opt.parse!(ARGV)

if ARGV.empty?
  target_year = Date.today.year.to_i
  target_month = Date.today.month.to_i
else
  target_year = ARGV[0].to_i
  target_month = ARGV[1].to_i
end

last_day = Date.new(target_year, target_month, -1).day

puts "      #{target_year}年#{target_month}月"

puts '日 月 火 水 木 金 土'

first_wday = Date.new(target_year,target_month,1).wday
print ' ' * first_wday * 3

(1..last_day).each do |day|
  print day.to_s.rjust(2)
  print ' '
  print "\n" if Date.new(target_year, target_month, day).saturday? || day == last_day
end