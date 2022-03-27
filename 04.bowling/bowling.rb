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

frames = []
shots.each_slice(2) do |s|
  frames << s
end

frames = shots.each_slice(2).to_a

point = 0
frames.each_with_index do |frame, index|
  point += frame.sum

  is_strike = frame[0] == 10
  is_spare = !is_strike && (frame.sum == 10)
  next_frame = frames[index + 1]
  after_next_frame = frames[index + 2]

  next unless index < 9

  point +=
    if is_spare
      next_frame[0]
    elsif is_strike
      if next_frame[0] == 10
        next_frame[0] + after_next_frame[0]
      else
        next_frame.sum
      end
    else
      0
    end
end

puts point
