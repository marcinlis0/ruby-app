require 'rails_helper'
require 'spec_helper'

require 'huffman_controller.rb'
  RSpec.describe 'huffman_controller.rb' do
  describe '#huffman_controller' do
  #  temp = HuffmanController.new()

  describe 'Node' do
    describe '#constructors' do
      it 'Should be defined' do
        expect { HuffmanController::Node.new([]) }.not_to raise_error
      end
      it 'Initialize without arguments should return good values' do
        node = HuffmanController::Node.new([])
        expect(node.instance_variable_get(:@code)).to eq('')
        expect(node.instance_variable_get(:@value)).to eq('')
        expect(node.instance_variable_get(:@number)).to eq(0)
        expect(node.instance_variable_get(:@left)).to eq(nil)
        expect(node.instance_variable_get(:@right)).to eq(nil)
      end
      it 'Initialize with 2 arguments should return good values' do
        node = HuffmanController::Node.new(['a', 1])
        expect(node.instance_variable_get(:@code)).to eq('')
        expect(node.instance_variable_get(:@value)).to eq('a')
        expect(node.instance_variable_get(:@number)).to eq(1)
        expect(node.instance_variable_get(:@left)).to eq(nil)
        expect(node.instance_variable_get(:@right)).to eq(nil)
      end
      it 'Initialize with 4 arguments should return good values' do
        node = HuffmanController::Node.new(['b', 2, HuffmanController::Node.new([]), HuffmanController::Node.new([])])
        expect(node.instance_variable_get(:@code)).to eq('')
        expect(node.instance_variable_get(:@value)).to eq('b')
        expect(node.instance_variable_get(:@number)).to eq(2)

      end
    end
    describe 'method' do
      it '#inc_number should be defined' do
        node = HuffmanController::Node.new(['c', 2])
        expect { node.inc_number }.not_to raise_error
      end
      it '#inc_number should increase a variable' do
        node = HuffmanController::Node.new(['c', 2])
        node.inc_number
        expect(node.instance_variable_get(:@number)).to eq(3)
      end
      it '#code_set should be defined' do
        node = HuffmanController::Node.new(['c', 2])
        expect { node.code_set('test') }.not_to raise_error
      end
      it '#code_set should set a code' do
        node = HuffmanController::Node.new([])
        node.code_set('test')
        expect(node.instance_variable_get(:@code)).to eq('test')
      end
    end
  end
  describe 'Huffman' do
    it '#make_node should be defined' do
      h = HuffmanController::Huffman.new
      expect { h.make_node('abc') }.not_to raise_error
    end
    it '#make_node should make good calculation' do
      h = HuffmanController::Huffman.new
      expect(h.make_node('aaabaccaaadddab').size).to eq(4)
    end
    it '#make_node should count all characters' do
      h = HuffmanController::Huffman.new
      nodes = h.make_node('aaab')
      expect(nodes[0].instance_variable_get(:@number)).to eq(3)
      expect(nodes[1].instance_variable_get(:@number)).to eq(1)
    end
    it '#extract_min should be defined' do
      h = HuffmanController::Huffman.new
      expect { h.extract_min([]) }.not_to raise_error
    end
    it '#extract_min should return the first smallest value' do
      h = HuffmanController::Huffman.new
      min = h.extract_min([HuffmanController::Node.new(['a', 2]), HuffmanController::Node.new(['b', 4]), HuffmanController::Node.new(['c', 2])])
      expect(min.instance_variable_get(:@number)).to eq(2)
      expect(min.instance_variable_get(:@value)).to eq('a')
    end
    it '#make_tree should be defined' do
      h = HuffmanController::Huffman.new
      nodes = h.make_node('abc')
      expect { h.make_tree(nodes, 1) }.not_to raise_error
    end
    it '#make_tree should return a root' do
      h = HuffmanController::Huffman.new
      nodes = h.make_node('aaabaccaaadddab')
      expect(h.make_tree(nodes, 1).instance_variable_get(:@value)).to eq('z3')
    end
    it '#make_tree should add all child number' do
      h = HuffmanController::Huffman.new
      nodes = h.make_node('aaabbc')
      expect(h.make_tree(nodes, 1).instance_variable_get(:@number)).to eq(6)
    end
    it '#make_tree should create a tree' do
      h = HuffmanController::Huffman.new
      nodes = h.make_node('ab')
      root = h.make_tree(nodes, 1)
      expect(root.instance_variable_get(:@value)).to eq('z1')
      expect(root.instance_variable_get(:@left).instance_variable_get(:@value)).to eq('a')
      expect(root.instance_variable_get(:@right).instance_variable_get(:@value)).to eq('b')
    end
    it '#make_code should be defined' do
      h = HuffmanController::Huffman.new
      nodes = h.make_node('test')
      root = h.make_tree(nodes, 1)
      node_list = []
      expect { h.make_code(root, node_list) }.not_to raise_error
    end
    it "#make_code doesn't loses any data" do
      h = HuffmanController::Huffman.new
      nodes = h.make_node('test')
      root = h.make_tree(nodes, 1)
      node_list = []
      expect(h.make_code(root, node_list).size).to eq(3)
    end
    it '#make_code should encrypt text' do
      h = HuffmanController::Huffman.new
      nodes = h.make_node('aaabaccaaadddab')
      root = h.make_tree(nodes, 1)
      node_list = []
      expect(h.make_code(root, node_list)[0].instance_variable_get(:@code)).to eq('00')
      expect(h.make_code(root, node_list)[1].instance_variable_get(:@code)).to eq('010')
      expect(h.make_code(root, node_list)[2].instance_variable_get(:@code)).to eq('011')
      expect(h.make_code(root, node_list)[3].instance_variable_get(:@code)).to eq('1')
    end
    it '#encrypt should be defined' do
      h = HuffmanController::Huffman.new
      expect { h.encrypt('abc') }.not_to raise_error
    end
    it '#encrypt should return 4 nodes' do
      h = HuffmanController::Huffman.new
      expect(h.encrypt('aaabaccaaadddab').size).to eq(4)
    end
    it '#get_code should be defined' do
      h = HuffmanController::Huffman.new
      expect { h.get_code('aaabbc') }.not_to raise_error
    end
    it '#get_code should return right code' do
      h = HuffmanController::Huffman.new
      expect(h.get_code('aaabbc')).to eq('000111110')
    end
    it '#decrypt should be defined' do
      h = HuffmanController::Huffman.new
      code = h.get_code('test text')
      expect { h.decrypt(code) }.not_to raise_error
    end
    it '#decrypt should decrypt the code' do
      h = HuffmanController::Huffman.new
      code = h.get_code('test text')
      expect(h.decrypt(code)).to eq('test text')
  end
end
end
end
