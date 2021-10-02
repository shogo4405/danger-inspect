Problem =
  Struct.new(:file, :line, :message, :severity) do
    def self.generate(node)
      Problem.new(
        node.get_elements('file').first.text.gsub('file://$PROJECT_DIR$/', ''),
        node.get_elements('line').first.text.to_i,
        node.get_elements('description').first.text,
        node.get_elements('problem_class').first.attributes['severity']
      )
    end
  end
