require 'rails_helper'
require 'spec_helper'

class HuffmanControllerTest < ActionDispatch::IntegrationTest
      test 'Should be defined' do
        expect { Node.new([]) }.not_to raise_error
      end
end
