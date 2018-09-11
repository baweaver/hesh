RSpec.describe Hesh do
  it "has a version number" do
    expect(Hesh::VERSION).not_to be nil
  end

  describe 'self' do
    describe '.of' do
      it 'creates a Hash of something, ya tell me!' do
        hash = Hesh.of { [] }
        hash[:a] << 1

        expect(hash[:a]).to eq([1])
      end
    end

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

    describe '.merge_sum' do
      it 'merges and sums together values' do
        expect(Hesh.merge_sum({a: 1}, {a: 2}, {a: 3})).to eq({:a=>6})
      end
    end

    describe '.merge_join' do
      it 'merges and joins together arrays' do
        expect(Hesh.merge_join({a: [1,2,3]}, {a: [4]})).to eq({:a=>[1, 2, 3, 4]})
      end
    end

    describe '.merge_with' do
      it 'merges with a function' do
        expect(
          Hesh.merge_with({a: [1,2,3]}, {a: [1,4]}) { |k, o, n| o - n }
        ).to eq({:a=>[2, 3]})
      end
    end

    describe '.merge_deep' do
      it 'merges deep!' do
        a = {a: {b: {c: 1, d: 2}}}
        b = {a: {b: {c: 4, d: 3}, x: 4}}

        expect(
          Hesh.merge_deep(a, b) { |k,o,n| o + n }
        ).to eq({
          :a=>{:b=>{:c=>5, :d=>5}, :x=>4}
        })
      end
    end
  end
end
