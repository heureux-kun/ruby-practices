#!/Users/heureux/.rbenv/versions/2.6.5/bin/ruby

require 'optparse'
require 'date'

days = ['日','月','火','水','木','金','土']

opt = OptionParser.new
opt.on('-y')
opt.on('-m')
opt.parse!(ARGV)

if ARGV.empty?
  targetYear = Date.today.year.to_i
  targetMonth = Date.today.month.to_i
else
  arguments = ARGV
  targetYear = arguments[0].to_i
  targetMonth = arguments[1].to_i
end

lastDay = Date.new(targetYear, targetMonth, -1)
lastDay = lastDay.day
puts lastDay

# カレンダータイトル
puts "      #{targetYear}年#{targetMonth}月"

# 曜日の表示
days.each_with_index do |day, index|
  if index == 6
    puts "#{day} "
  else
    print "#{day} "
  end
end

# 日付部分の出力
# 初日の曜日の数字を確認し、数字x3スペース開ける
firstWDay = Date.new(targetYear,targetMonth,1).wday
print ' ' * firstWDay * 3

(1..lastDay).each do |day|
  day < 10 ? dayPreSpace = ' ' : dayPreSpace = ''
  
  # 土曜日だったら
  if Date.new(targetYear,targetMonth,day).wday.to_i == 6 || day == lastDay
    puts day.to_s.rjust(2)  + ' '
  else
    print day.to_s.rjust(2)  + ' '
  end
end