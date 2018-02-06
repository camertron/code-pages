require 'spec_helper'

describe CodePages do
  describe '#[]' do
    subject { described_class[875] }

    it 'retrieves code pages by id' do
      expect(subject).to be_a(CodePages::CodePage)
      expect(subject.id).to eq(875)
    end
  end

  describe '#supported_ids' do
    subject { described_class.supported_ids }

    it 'rerieves a list of all available code page ids' do
      expect(subject.all? { |id| id.is_a?(Integer) }).to eq(true)
      expect(subject).to include(875)
      expect(subject).to include(10006)
      expect(subject).to include(1251)
    end
  end

  describe '#supported_names' do
    subject { described_class.supported_names }

    it 'rerieves a list of all available code page ids' do
      expect(subject.all? { |id| id.is_a?(String) }).to eq(true)
      expect(subject).to include('cp875')
      expect(subject).to include('cp860')
      expect(subject).to include('cp1251')
      expect(subject).to include('shift_jis')
      expect(subject).to include('apple_hebrew')
    end
  end

  describe '#supports?' do
    it 'returns true if the code page is supported' do
      expect(described_class.supports?(28605)).to eq(true)
    end

    it 'returns false if the code page is not supported' do
      expect(described_class.supports?(38)).to eq(false)
    end
  end

  describe '#all' do
    subject { described_class.all }

    it 'returns a hash of all code pages' do
      subject.each_pair do |_, code_page|
        expect(code_page).to be_a(CodePages::CodePage)
      end
    end

    it 'includes certain code pages' do
      expect(subject).to include('cp950')
      expect(subject).to include('cp1250')
      expect(subject).to include('mac_roman')
      expect(subject).to include('apple_cyrillic')
    end
  end
end
