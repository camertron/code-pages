require 'open-uri'
require 'yaml'

module CodePages
  class Importer
    def self.import(manifest, output_path)
      new(manifest, output_path).import
    end

    attr_reader :manifest, :output_path

    def initialize(manifest, output_path)
      @manifest = manifest
      @output_path = output_path
    end

    def import
      manifest.each do |props|
        STDOUT.write("Importing #{props['name']}... ")
        import_code_page(props)
        puts 'done.'
      end
    end

    private

    def import_code_page(props)
      output_file = File.join(output_path, "#{props['name']}.yml")
      code_page = get_code_page(props['url'])
      File.write(output_file, YAML.dump(code_page))
    end

    def get_code_page(url)
      io = open(url)

      {}.tap do |code_page|
        parse_resource(io) do |line|
          next if (line[1] || '').empty?
          code_page[hex2dec(line[0])] = hex2dec(line[1])
          break if line[0].upcase == '0XFF'
        end
      end
    end

    def hex2dec(hex_str)
      hex_str[2..-1].to_i(16)
    end

    def parse_resource(io)
      io.each_line do |line|
        unless line[0] == '#'
          comment_idx = if idx = line.index('#')
            idx - 1 # consume #
          else
            line.size
          end

          line = line.chomp[0..comment_idx]

          if line.size > 0
            yield line.split("\t", -1).map(&:strip)
          end
        end
      end
    end
  end
end
