require 'thor'

module BrakemanTranslateCheckstyleFormat
  class CLI < Thor
    include ::BrakemanTranslateCheckstyleFormat::Translate
    desc 'translate', 'Exec Translate'
    option :data
    option :file
    def translate
      data = fetch_data(options)
      json = parse(data)
      checkstyle = trans(json)
      checkstyle.write(STDOUT, 2)
    end

    no_commands do
      def fetch_data(options)
        data = \
          if options[:data]
            options[:data]
          elsif options[:file]
            File.read(options[:file])
          elsif !$stdin.tty?
            ARGV.clear
            ARGF.read
          end

        fail NoInputError if !data || data.empty?

        data
      end
    end
  end
end
