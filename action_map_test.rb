# Run program:
# You must have RSpec installed. To install RSpec, run "gem install rspec"
# Run "rspec action_map_test.rb"

require 'rspec/autorun'

test_file = ARGV[1] || 'action_map'
require_relative test_file

describe 'Test' do
  context 'action' do
    it 'returns an action correctly' do
      Test.action_map.each do |key, value|
        expect(Test.action(key)).to eql(value)
      end
    end

    it 'returns nil for nonexistent action' do
      expect(Test.action('nonexistent_action')).to be nil
    end
  end # context 'action'

  context 'add_action' do
    it 'adds action correctly' do
      Test.add_action({'add_action_test_1' => '🙇'})
      expect(Test.action('add_action_test_1')).to eql('🙇')
    end
  end

  context 'update_action' do
    it 'updates existing action correctly' do
      Test.update_action({'add_action_test_1' => '💃'})
      expect(Test.action('add_action_test_1')).to eql('💃')
    end
  end

  context 'delete_action' do
    it 'deletes actions correctly' do
      Test.delete_action(['add_action_test_1'])
       expect(Test.action('add_action_test_1')).to be nil
    end
  end
end