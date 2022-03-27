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
frames.each_with_index do |frame, index|
  current_status =
    if frame[0] == 10
      'strike'
    elsif frame.sum == 10
      'spare'
    else
      ''
    end

  point += frame.sum
  if index < 9
    point +=
      case current_status
      when 'spare'
        frames[index + 1][0]
      when 'strike'
        if frames[index + 1][0] == 10
          frames[index + 1][0] + frames[index + 2][0]
        else
          frames[index + 1].sum
        end
      else
        0
      end
  end

end
puts point
