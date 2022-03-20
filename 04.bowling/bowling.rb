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
count = 0
prev_status = ''
prev_prev_status = ''
frames.each do |frame|
  count += 1
  point +=
    case prev_status
    when 'spare'
      frame[0] + frame.sum
    when 'strike'
      frame.sum * 2
    else
      frame.sum
    end

  # 前々回と前回がストライクだった時、さらにframe[0]を加算する
  if prev_prev_status == 'strike' && prev_status == 'strike' && count != 11
    point += frame[0]
  end

  # binding.irb

  prev_prev_status = prev_status
  prev_status =
    if frame[0] == 10
      'strike'
    elsif frame.sum == 10
      'spare'
    else
      ''
    end
end
puts point
