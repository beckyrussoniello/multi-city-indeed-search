class ArrayExtension

  Array.class_eval do
    def sort_by_date
      self.sort! {|x,y| y["date"].to_datetime <=> x["date"].to_datetime}
    end
  end

  Array.class_eval do

    def ensure_uniq # sometimes duplicate postings have different URLs...go figure
     # without_url = self.inject([]){|a,i| a << i.reject{|k,v| k == :url}}
      grouped = self.group_by {|i| i.reject{|k,v| k == :url}}
      ary = []
      grouped.each do |group| ary << group.first end
      ary
    end
  end

=begin
    def listify
      self.each do |item| item = item.strip end
      str = self[0].to_s
      return str if self.size == 1
      self[1..-2].each do |item| str << ", #{item.capitalize}" end
      str << " or #{self[-1]}"
    end 
=end

end
