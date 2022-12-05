#!/usr/bin/env ruby

SHAPE_SCORE = { :rock => 1, :paper => 2, :scissors => 3 }
RESULT_SCORE = { :lose => 0, :draw => 3, :win => 6 }

def me(opp, result)
  case opp
    when :rock
      { :draw => :rock, :win => :paper, :lose => :scissors }[result]
    when :paper
      { :draw => :paper, :win => :scissors, :lose => :rock }[result]
    when :scissors
      { :draw => :scissors, :win => :rock, :lose => :paper }[result]
  end
end

def score(me, result)
  SHAPE_SCORE[me] + RESULT_SCORE[result]
end

OPP_SYMBOLS = { 'A' => :rock, 'B' => :paper, 'C' => :scissors }
RESULT_SYMBOLS = { 'X' => :lose, 'Y' => :draw, 'Z' => :win }

input = ARGF.readlines.map{|line| line.split}
  .map{|opp, result| [OPP_SYMBOLS[opp], RESULT_SYMBOLS[result]]}

puts input.map{|opp, result| [me(opp, result), result]}
  .map{|me, result| score(me, result)}.sum
