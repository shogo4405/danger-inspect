require_relative 'problem'

module Danger
  # This is your plugin class. Any attributes or methods you expose here will
  # be available from within your Dangerfile.
  #
  # To be published on the Danger plugins site, you will need to have
  # the public interface documented. Danger uses [YARD](http://yardoc.org/)
  # for generating documentation from your plugin source, and you can verify
  # by running `danger plugins lint` or `bundle exec rake spec`.
  #
  # You should replace these comments with a public description of your library.
  #
  # @example Ensure people are well warned about merging on Mondays
  #
  #          my_plugin.warn_on_mondays
  #
  # @see  shogo4405/danger-inspect
  # @tags monday, weekends, time, rattata
  #
  class DangerInspect < Plugin
    # An attribute that you can read/write from your Dangerfile
    #
    # @return   [Array<String>]
    attr_accessor :my_attribute

    # A method that you can call from your Dangerfile
    # @return   [Array<String>]
    #
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
