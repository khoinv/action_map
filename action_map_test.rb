# Run program:
# You must have RSpec installed. To install RSpec, run 'gem install rspec'
# Run 'rspec action_map_test.rb'

require 'rspec/autorun'

TEST_IN_LANGS = %w(vi en)
test_file = ARGV[1] || 'action_map'
require_relative test_file

describe 'Test' do
  TEST_IN_LANGS.each {|lang|
    context 'action' do
      it 'returns an action correctly' do
        vi_instance = Test.get_instance(lang)
        vi_instance.action_map.each do |key, value|
          expect(vi_instance.action(key)).to eql(value)
        end
      end

      it 'returns nil for nonexistent action' do
        vi_instance = Test.get_instance(lang)
        expect(vi_instance.action('nonexistent_action')).to be nil
      end
    end # context 'action'

    context 'add_action' do
      it 'adds action correctly' do
        vi_instance = Test.get_instance(lang)
        vi_instance.add_action({'add_action_test_1' => '🙇' << '__' << lang})
        expect(vi_instance.action('add_action_test_1')).to eql('🙇' << '__' << lang)
      end
    end

    context 'update_action' do
      it 'updates existing action correctly' do
        vi_instance = Test.get_instance(lang)
        vi_instance.update_action({'add_action_test_1' => '💃' << '__' << lang})
        expect(vi_instance.action('add_action_test_1')).to eql('💃' << '__' << lang)
      end
    end

    context 'delete_action' do
      it 'deletes actions correctly' do
        vi_instance = Test.get_instance(lang)
        vi_instance.delete_action(['add_action_test_1'])
        expect(vi_instance.action('add_action_test_1')).to be nil
      end
    end
  }
end
