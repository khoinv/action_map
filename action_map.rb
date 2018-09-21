require 'json'

class Test
  ACTION_MAP_FILE_PATH_FORMAT = 'action_map_%s.json'

  @@lang_instance_map = {}

  # def initialize
  #   raise "use getInstance function!"
  # end

  class << self
    def get_instance(lang)
      if (!@@lang_instance_map.has_key?(lang))
        new_instance = Test.new
        new_instance.init(ACTION_MAP_FILE_PATH_FORMAT % [lang])
        @@lang_instance_map[lang] = new_instance
      end
      @@lang_instance_map[lang]
    end
  end

  def init(action_map_file_path)
    @action_map_file_path = action_map_file_path
    @action_map ||= JSON.parse(File.read(action_map_file_path))
  end

  def action(verb)
    @action_map[verb]
  end

  def delete_action(verbs)
    verbs.each {|verb| @action_map.delete(verb)}
    update(@action_map)
  end

  def add_action(action_map)
    update_action(action_map)
  end

  def update_action(action_map)
    @action_map.merge!(action_map)
    update(@action_map)
  end

  def action_map
    @action_map
  end

  def update(action_maps)
    File.write(@action_map_file_path, JSON.pretty_generate(action_maps))
  end
end
