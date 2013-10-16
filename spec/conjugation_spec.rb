# encoding: utf-8
require_relative '../lib/conjugation'

describe Conjugation do

  let(:regular_conj) { Conjugation.new(NepaliVerb.new('गर्नु')) }

  describe '#tense' do
    it 'should default to "present"' do
      regular_conj.tense.should == 'present'
    end

    it 'should be changeable to "simple past"' do
      regular_conj.tense = 'simple past'
      regular_conj.tense.should == 'simple past'
    end
  end

  describe '#subject' do
    it 'should default to "म"' do
      regular_conj.subject.should == 'म'
    end

    it 'should be changeable to "तिमी"' do
      regular_conj.subject = 'तिमी'
      regular_conj.subject.should == 'तिमी'
    end
  end

  describe '#negative' do
    it 'should default to false' do
      regular_conj.negative.should be_false
    end
  end

  describe '#starts_with_vowel_diacritic' do
    it 'should be false for empty string' do
      Conjugation.starts_with_vowel_diacritic('').should be_false
    end

    it 'should be true for े' do
      Conjugation.starts_with_vowel_diacritic('े').should be_true
    end

    it 'should be true for ि' do
      Conjugation.starts_with_vowel_diacritic('ि').should be_true
    end
  end

  ####### REGULAR VERB ######

  context 'With a regular verb like "गर्नु"' do

    describe 'conjugation' do
      subject { regular_conj.to_s }

      context 'in present tense' do
        # present tense is the default

        context 'with "म"' do
          before { regular_conj.subject = 'म' }
          it { should == 'गर्छु' }

          context 'negative' do
            before { regular_conj.negative = true }
            it { should == 'गर्दिन' }
          end

        end

        context 'with "तिमी"' do
          before { regular_conj.subject = 'तिमी' }
          it { should == 'गर्छौ' }

          context 'negative' do
            before { regular_conj.negative = true }
            it { should == 'गर्दैनौ' }
          end
        end
      end # present tense

      context 'in simple past tense' do
        before { regular_conj.tense = 'simple past' }

        context 'with "म"' do
          before { regular_conj.subject = 'म' }
          it { should == 'गरेँ' }

          context 'negative' do
            before { regular_conj.negative = true }
            it { should == 'गरिनँ' }
          end
        end

        context 'with "तिमी"' do
          before { regular_conj.subject = 'तिमी' }
          it { should == 'गर्यौ' }

          context 'negative' do
            before { regular_conj.negative = true }
            it { should == 'गरेनौ' }
          end
        end
      end # simple past tense
    end # conjugation
  end

  context 'With irregular verb जानु' do
    let(:janu_conj) { Conjugation.new(NepaliVerb.JANU) }

    describe 'conjugation' do
      subject { janu_conj.to_s }

      context 'in simple past tense' do
        before { janu_conj.tense = 'simple past' }

        { 'म' => 'गएँ',
          'तिमी' => 'गयौ' }
          .each do |subject, verb|
          it "#{subject} -> #{verb}" do
            janu_conj.subject = subject
            should == verb
          end
        end
      end

      context 'in completed past tense' do
        before { janu_conj.tense = 'completed past' }

        context 'with "म"' do
          before { janu_conj.subject = 'म' }
          it { should == 'गएको छु' }
        end

        context 'with "तिमी"' do
          before { janu_conj.subject = 'तिमी' }
          it { should == 'गएका छौ' }
        end
      end
    end # conjugation
  end # "जानु"

  context 'With a single-vowel verb like "खानु"' do
    let(:single_vowel_verb) { Conjugation.new(NepaliVerb.new('खानु')) }

    context 'in present tense' do
      it 'should conjugate for "म" by adding a half न' do
        single_vowel_verb.subject = 'म'
        single_vowel_verb.to_s.should == 'खान्छु'
      end

      context 'negative' do
        before { single_vowel_verb.negative = true }

        it 'should conjugate for "म" by adding nasalization over the last vowel' do
          single_vowel_verb.to_s.should == 'खाँदिन'
        end
      end
    end
  end


  context 'With a double-vowel verb like "पकाउनु"' do
    let(:double_vowel_verb) { Conjugation.new(NepaliVerb.new('पकाउनु')) }

    context 'in completed past tense' do
      before do
        double_vowel_verb.tense = 'completed past'
      end

      it 'should conjugate for "म"' do
        double_vowel_verb.subject = 'म'
        double_vowel_verb.to_s.should == 'पकाएको छु'
      end
    end

    context 'in simple past tense' do
      before { double_vowel_verb.tense = 'simple past' }

      it 'should conjugate the negative for "म" by using full "इ"' do
        double_vowel_verb.subject = 'म'
        double_vowel_verb.negative = true
        double_vowel_verb.to_s.should == 'पकाइनँ'
      end
    end

    context 'in present tense' do
      it 'should conjugate for "म" by adding nasalization over the last vowel' do
        double_vowel_verb.subject = 'म'
        double_vowel_verb.to_s.should == 'पकाउँछु'
      end

      context 'negative' do
        before { double_vowel_verb.negative = true }

        it 'should conjugate for "म" by adding nasalization over the last vowel' do
          double_vowel_verb.to_s.should == 'पकाउँदिन'
        end
      end

    end

  end

end