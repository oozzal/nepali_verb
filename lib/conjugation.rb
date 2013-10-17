# encoding: utf-8
require_relative 'nepali_verb'

class Conjugation
  PAST_ROOT_TENSES = ['simple past', 'completed past']
  SUFFIXES = {
      'present' => {
        'म' => ['छु', 'दिन'],
        'तिमी' => ['छौ', 'दैनौ']
      },
      'simple past' => {
        'म' => ['एँ', 'इनँ'],
        'तिमी' => ['यौ', 'एनौ']
      },
      'completed past' => {
        'म' => ['एको छु', 'एको छैन'],
        'तिमी' => ['एका छौ', 'एका छैनौ']
      },
      'simple future' => {
        'म' => ['ने छु', 'ने छैन'],
        'तिमी' => ['ने छौ', 'ने छैनौ']
      }
    }

  attr_accessor :tense, :subject, :negative

  def initialize(nepali_verb)
    @nepali_verb = nepali_verb
    @subject = 'म'
    @tense = 'present'
    @negative = false
  end

  def to_s
    self.class.join_root_and_suffix(safe_root, suffix)
  end

  def safe_root
    self.class.nasalized_root_for_suffix(tensed_root, suffix)
  end

  def suffix
    SUFFIXES[tense][subject][negative ? 1 : 0]
  end

  def tensed_root
    PAST_ROOT_TENSES.include?(tense) ? @nepali_verb.past_root : @nepali_verb.root
  end

  ### CLASS METHODS ###

  def self.ends_with_halant(text)
    (text[-1, 1] == '्')
  end

  def self.starts_with_vowel_diacritic(text)
    ['े', 'ि'].include? text[0, 1]
  end

  def self.starts_with_full_vowel(text)
    ['ए', 'इ'].include? text[0, 1]
  end

  def self.convert_initial_full_vowel_to_diacritic(text)
    diacritic_by_vowel = {'ए' => 'े', 'इ' => 'ि'}
    first_vowel = text[0, 1]
    diacritic = diacritic_by_vowel[first_vowel]
    diacritic + text[1..-1]
  end

  def self.nasalized_root_for_suffix(root, suffix)
    suffix_first = suffix[0, 1]
    root_last  = root[-1, 1]
    root_last2 = root[-2, 2]

    if suffix_first == 'छ'
      if root_last == 'ा'
        # Add half 'न' between 'ा' and 'छ', e.g. 'खान्छु'
        return root + 'न्'
      elsif root_last2 == 'ाउ'
        # Add nasalization over the last vowel, e.g. 'पकाउँछु'
        return root + 'ँ'
      end
    elsif suffix_first == 'द'
      if ['ा', 'उ'].include? root_last
        return root + 'ँ'
      end
    end
    root
  end

  def self.join_root_and_suffix(root, suffix)
    if ends_with_halant(root) && starts_with_full_vowel(suffix)
        # remove halant
        root[0..-2] + convert_initial_full_vowel_to_diacritic(suffix)
    else
      root + suffix
    end
  end

end