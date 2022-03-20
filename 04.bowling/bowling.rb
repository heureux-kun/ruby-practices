#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pry'

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

# 数を2つずつに分けてframes配列に入れている
frames = []
shots.each_slice(2) do |s|
  frames << s
end

point = 0
current_status = ''
prev_status = ''
frames.each_with_index do |frame, index|
  current_status = 
    if frame[0] == 10
      'strike'
    elsif frame.sum == 10
      'spare'
    else
      ''
    end

  if index < 9
    point +=
      case current_status
      when 'spare'
        # 次の1投の点を加算する
        frame.sum + frames[index+1][0]
        # binding.irb
      when 'strike'
        # 次の2投の点を加算する
        # 次がスペアだった場合
        if frames[index+1][0] != 10
          frame.sum + frames[index+1].sum
        # 次がストライクだった場合
        else
          frame.sum + frames[index+1][0] + frames[index+2][0]
        end
      else
        frame.sum
      end
  else
    point += frame.sum
  end

  prev_status = current_status
  # puts "#{index+1}回目"
  # binding.irb
end
puts point
