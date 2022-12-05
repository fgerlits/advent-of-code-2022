#!/usr/bin/env ruby

SHAPE_SCORE = { :rock => 1, :paper => 2, :scissors => 3 }
RESULT_SCORE = { :lose => 0, :draw => 3, :win => 6 }

def result(opp, me)
  case opp
    when :rock
      { :rock => :draw, :paper => :win, :scissors => :lose }[me]
    when :paper
      { :rock => :lose, :paper => :draw, :scissors => :win }[me]
    when :scissors
      { :rock => :win, :paper => :lose, :scissors => :draw }[me]
  end
end

def score(me, result)
  SHAPE_SCORE[me] + RESULT_SCORE[result]
end

OPP_SYMBOLS = { 'A' => :rock, 'B' => :paper, 'C' => :scissors }
ME_SYMBOLS = { 'X' => :rock, 'Y' => :paper, 'Z' => :scissors }

input = ARGF.readlines.map{|line| line.split}
  .map{|opp, me| [OPP_SYMBOLS[opp], ME_SYMBOLS[me]]}

puts input.map{|opp, me| [me, result(opp, me)]}
  .map{|me, result| score(me, result)}.sum
