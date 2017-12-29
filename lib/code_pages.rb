require 'yaml'

module CodePages
  autoload :CodePage, 'code-pages/code_page'
  autoload :Importer, 'code-pages/importer'

  class << self
    def [](index)
      all[index]
    end

    def supported_ids
      @supported_ids ||= all.keys
    end

    def supports?(id)
      supported_ids.include?(id)
    end

    def all
      @all ||= manifest.each_with_object({}) do |props, ret|
        ret[props['code_page']] = CodePage.new(
          props['code_page'], File.join(resources_dir, "#{props['code_page']}.yml")
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
  end
end
