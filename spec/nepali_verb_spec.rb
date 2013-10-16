# encoding: utf-8
require_relative '../lib/nepali_verb'

describe NepaliVerb do
  let(:regular_verb) { NepaliVerb.new('गर्नु') }

  describe '#infinitive' do
    it 'should be the same as a valid constructor argument' do
      regular_verb.infinitive.should == 'गर्नु'
    end

    it 'should end in "नु"' do
      regular_verb.infinitive[-2, 2] == 'नु'
    end

    it 'should be DEFAULT_INFINITIVE when constructed with no parameters' do
      NepaliVerb.new().infinitive.should == 'गर्नु'
    end

   it 'should be DEFAULT_INFINITIVE when constructed with nil' do
      NepaliVerb.new(nil).infinitive.should == 'गर्नु'
    end

    it 'should be DEFAULT_INFINITIVE when constructed with empty string' do
      NepaliVerb.new('').infinitive.should == 'गर्नु'
    end
  end

  context 'With a regular verb like "गर्नु"' do
    describe '#root' do
      it 'should be the infinitive minus "नु"' do
        regular_verb.root.should == 'गर्'
      end
    end

    describe '#past_root' do
      it 'should be the the same as root' do
        regular_verb.past_root.should == regular_verb.root
      end
    end
  end  

  context 'With irregular verb जानु' do
    let(:janu_verb) { NepaliVerb.JANU }

    describe '#root' do
      it 'should be regular' do
        janu_verb.root.should == 'जा'
      end
    end

    describe '#past_root' do
      it 'is set via an optional constructor parameter' do
        janu_verb.past_root.should == 'ग'
      end
    end  
  end

  context 'With a double-vowel verb like "पकाउनु"' do
    let(:double_vowel_verb) { NepaliVerb.new('पकाउनु') }

    describe '#root' do
      it 'should be regular' do
        double_vowel_verb.root.should == 'पकाउ'
      end
    end

    describe '#past_root' do
      it 'should drop the second vowel' do
        double_vowel_verb.past_root.should == 'पका'
      end
    end
  end


end
