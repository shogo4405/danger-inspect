require_relative 'problem'

module Danger
  # Danger plugin for code inspections.
  #
  # @example Parse the XML files, and report messages.
  #
  #          inspect.report 'path/to/inspect-result_dir'
  #
  # @see  shogo4405/danger-inspect
  # @tags lint
  #
  class DangerInspect < Plugin
    # Report code inspections messages.
    #
    # @return   [void]
    def report(dir)
      problems = []
      Dir.glob("#{dir}/*.xml") do |file|
        problems.push(read_xml(file)) unless file.include?('.descriptions.xml')
      end
      comment(problems.flatten)
    end

    private

    def read_xml(file)
      require 'rexml/document'
      problems = []
      xml = REXML::Document.new(File.read(file))
      xml
        .get_elements('problems/problem')
        .each { |element| problems.push(Problem.generate(element)) }
      problems
    end

    def comment(problems)
      problems.each do |problem|
        case problem.severity.downcase
        when 'info'
          message(problem.message, file: problem.file, line: problem.line)
        else
          warn(problem.message, file: problem.file, line: problem.line)
        end
      end
    end
  end
end
