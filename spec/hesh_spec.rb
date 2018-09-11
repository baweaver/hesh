RSpec.describe Hesh do
  it "has a version number" do
    expect(Hesh::VERSION).not_to be nil
  end

  describe 'self' do
    describe '.of_array' do
      it 'creates a Hash of arrays' do
        hash = Hesh.of_array
        hash[:a] << 1
        expect(hash[:a]).to eq([1])
      end
    end

    describe '.of_hash' do
      it 'creates a Hash of hashes' do
        hash = Hesh.of_hash
        hash[:a][:b] = 2
        expect(hash[:a]).to eq({ b: 2 })
      end
    end

    describe '.of_infinite_hash' do
      it 'creates an infinitely deep hash' do
        hash = Hesh.of_infinite_hash
        hash[:a][:b][:c][:d][:e] = 1
        expect(hash).to eq({ a: { b: { c: { d: { e: 1} } } } })
      end
    end

    describe '.count_from' do
      it 'counts from a list and a function' do
        expect(Hesh.count_from(%w(a a a b b b b c c))).to eq({
          "a" => 3, "b" => 4, "c" => 2
        })
      end
    end

    describe '.invert_relation' do
      it 'inverts a relation' do
        expect(
          Hesh.invert_relation({ 1 => %w(a b), 2 => %w(b c), 3 => %w(a c) })
        ).to eq({
          "a" => [1, 3], "b" => [1, 2], "c" => [2, 3]
        })
      end
    end
  end
end
