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
      bug_instances = xml['BugCollection']['BugInstance']
      if bug_instances.blank?
        FindbugsTranslateCheckstyleFormat::Translate.set_dummy(xml, checkstyle)
        return doc
      end

      bug_instances = [bug_instances] if bug_instances.is_a?(Hash)
      bug_instances.each do |bug_instance|
        source_line = bug_instance['SourceLine']
        file = checkstyle.add_element('file',
                                      'name' => FindbugsTranslateCheckstyleFormat::Translate.fqcn_to_path(source_line['@classname'], xml)
                                     )
        file.add_element('error',
                         'line' => source_line['@start'],
                         'severity' => 'error',
                         'message' => FindbugsTranslateCheckstyleFormat::Translate.create_message(bug_instance)
                        )
      end

      doc
    end

    def self.fqcn_to_path(fqcn, xml)
      path = fqcn.tr('.', '/').tr('$[0-9]+', '') + '.java'
      src_dirs = xml['BugCollection']['Project']['SrcDir']
      src_dirs = [src_dirs] unless src_dirs.is_a?(Array)
      src_dirs.find { |src| !src.index(path).nil? }
    end

    def self.set_dummy(xml, checkstyle)
      dummy_src_dir = xml['BugCollection']['Project']['SrcDir']
      dummy_src_dir = dummy_src_dir.first if dummy_src_dir.is_a?(Array)

      checkstyle.add_element('file',
                             'name' => dummy_src_dir
                            )

      checkstyle
    end

    def self.create_message(bug_instance)
      link = "http://findbugs.sourceforge.net/bugDescriptions.html##{bug_instance['@type']}"
      "[#{bug_instance['@category']}][#{bug_instance['@type']}] #{bug_instance['LongMessage']}\n#{link}"
    end
  end
end
