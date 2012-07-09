class ArrayExtension

  Array.class_eval do
    def sort_by_date
      self.sort! {|x,y| y["date"].to_datetime <=> x["date"].to_datetime}
    end
  end

  Array.class_eval do
    def listify
      str = self[0].to_s
      return str if self.size == 1
      self[1..-2].each do |item| str << ", #{item.capitalize}" end
      str << " or #{self[-1]}"
    end 
  end

end
