class ArrayExtension

  Array.class_eval do
    def sort_by_date
      self.sort! {|x,y| y["date"].to_datetime <=> x["date"].to_datetime}
    end
  end

end
