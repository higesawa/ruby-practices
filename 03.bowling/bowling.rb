#!/usr/bin/env ruby
# frozen_string_literal: true

def parse_frames(score)
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
  frames = shots.each_slice(2).to_a
end

def strike?(frame)
  frame[0] == 10
end

def strike_score(next_frame, next_next_frame)
  10 + if strike?(next_frame)
         next_frame[0] + next_next_frame[0]
       else
         next_frame[0..1].sum
       end
end

def spare?(frame)
  frame.sum == 10 && !frame[1].zero?
end

def spare_score(next_frame)
  10 + next_frame[0]
end

def frame_point(frames, frame, index)
  next_frame = frames[index + 1]
  next_next_frame = frames[index + 2]
  if strike?(frame)
    strike_score(next_frame, next_next_frame)
  elsif spare?(frame)
    spare_score(next_frame)
  else
    frame.sum
  end
end

score = ARGV[0]
frames = parse_frames(score)
point = 0
frames.each_with_index do |frame, i|
  break if i > 9

  point += frame_point(frames, frame, i)
end
puts point
