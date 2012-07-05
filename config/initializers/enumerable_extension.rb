class EnumerableExtension
  Enumerable.class_eval do
    def mode
      group_by do |e|
        e
      end.values.select{|val| val.size > 1}.max_by(&:size).first
    end
  end
end
