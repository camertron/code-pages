require 'yaml'

module CodePages
  autoload :CodePage, 'code-pages/code_page'
  autoload :Importer, 'code-pages/importer'

  class << self
    def [](name_or_id)
      from_name(name_or_id) || from_id(name_or_id)
    end

    def supported_ids
      @supported_ids ||= all.map { |_, cp| cp.id }.compact
    end

    def supported_names
      @supported_names ||= all.keys
    end

    def supports?(id_or_name)
      supported_ids.include?(id_or_name) || supported_names.include?(id_or_name)
    end

    def all
      @all ||= manifest.each_with_object({}) do |props, ret|
        ret[props['name']] = CodePage.new(
          props['code_page'],
          props['name'],
          File.join(resources_dir, "#{props['name']}.yml")
        )
      end
    end

    def manifest
      @manifest ||= YAML.load_file(
        File.join(resources_dir, 'code_page_manifest.yml')
      )
    end

    def resources_dir
      @resources_dir ||= File.expand_path('../../resources', __FILE__)
    end

    private

    def from_name(name)
      all[name]
    end

    def from_id(id)
      id_map[id] ||= all.each do |_, cp|
        if cp.id  # don't allow matching on nil
          return cp if cp.id == id
        end
      end

      nil
    end

    def id_map
      @id_map ||= {}
    end
  end
end
