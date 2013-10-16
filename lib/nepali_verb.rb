# encoding: utf-8
class NepaliVerb
  DEFAULT_INFINITIVE = 'गर्नु'

  def self.JANU() NepaliVerb.new('जानु', 'ग') end

  attr_reader :infinitive

  def initialize(infinitive = '', past_root = nil)
    @infinitive = infinitive.to_s.empty? ? DEFAULT_INFINITIVE : infinitive
    @past_root = past_root
  end

  def root
    # Remove 'नु'
    infinitive[0..-3]
  end  

  def past_root
    @past_root ||
      # double-vowel verbs, e.g. 'पकाउनु'
      #TODO: generalize for other double-vowel cases, e.g. aunu, piunu
      if root[-2, 2] == 'ाउ'
        # remove the second vowel
        root[0..-2]
      else
        root
      end
  end  
end