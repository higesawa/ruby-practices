#!/usr/bin/env ruby
# frozen_string_literal: true

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
shots.each_slice(2) { |s| frames << s }
frames.map! { |frame| frame == [10, 0] ? [10] : frame }
until frames.length == 10
  last_frame = frames.pop
  frames[-1] += last_frame
end

point = 0
frames.each_with_index do |frame, i|
  point += if frame == [10]
             if frames[i + 1] == [10]
               frame.sum + frames[i + 1][0] + frames[i + 2][0]
             else
               frame.sum + frames[i + 1][0] + frames[i + 1][1]
             end
           elsif frame.sum == 10 && frame.length == 2
             frame.sum + frames[i + 1][0]
           else
             frame.sum
           end
end
puts point
