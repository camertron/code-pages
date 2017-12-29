require 'spec_helper'

describe CodePages::CodePage do
  let(:code_page) { CodePages[37] }

  describe '#unicode_mapping' do
    subject { code_page.unicode_mapping }

    it 'maps code page characters to unicode code points' do
      expect(subject[4]).to eq(156)
      expect(subject[120]).to eq(204)
      expect(subject[242]).to eq(50)
      expect(subject[255]).to eq(159)
    end
  end

  describe '#to_utf8' do
    it 'converts the given string from the code page to utf8' do
      expect(code_page.to_utf8('abc')).to eq('/ÂÄ')
    end
  end
end
