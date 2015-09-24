require 'json'
require 'rexml/document'

module BrakemanTranslateCheckstyleFormat
  module Translate
    def parse(json)
      JSON
        .parse(json)
    end

    def trans(json)
      doc = REXML::Document.new
      doc << REXML::XMLDecl.new('1.0', 'UTF-8')

      checkstyle = doc.add_element('checkstyle')
      warnings = json['warnings']
      if warnings.empty?
        BrakemanTranslateCheckstyleFormat::Translate.set_dummy(json, checkstyle)
        return doc
      end

      warnings.each do |warning|
        file = checkstyle.add_element('file',
                                      'name' => BrakemanTranslateCheckstyleFormat::Translate.convert_to_absolute(warning, json)
                                     )
        file.add_element('error',
                         'line' => warning['line'],
                         'severity' => 'error',
                         'message' => BrakemanTranslateCheckstyleFormat::Translate.create_message(warning)
                        )
      end

      doc
    end

    def self.convert_to_absolute(warning, json)
      "#{json['scan_info']['app_path']}/#{warning['file']}"
    end

    def self.set_dummy(json, checkstyle)
      checkstyle.add_element('file',
                             'name' => ''
                            )

      checkstyle
    end

    def self.create_message(warning)
      "[#{warning['confidence']}][#{warning['warning_type']}] #{warning['message']}\n#{warning['link']}"
    end
  end
end
