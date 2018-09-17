require 'json'

class Test
  ACTION_MAP_FILE_PATH = 'action_map.json'

  class << self
    def init
      @@action_map ||= JSON.parse(File.read(ACTION_MAP_FILE_PATH))
    end

    def action(verb)
      @@action_map[verb]
    end

    def delete_action(verbs)
      verbs.each {|verb| @@action_map.delete(verb)}
      update(@@action_map)
    end

    def add_action(action_map)
      update_action(action_map)
    end

    def update_action(action_map)
      @@action_map.merge!(action_map)
      update(@@action_map)
    end

    def action_map
      @@action_map
    end

    def update(action_maps)
      File.write(ACTION_MAP_FILE_PATH, JSON.pretty_generate(@@action_map))
    end
  end

  init
end
