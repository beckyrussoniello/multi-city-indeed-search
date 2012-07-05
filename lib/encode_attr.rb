module EncodeAttr

  def encode
    attribute = self.attributes.keys[1]
    eval <<-end_eval
      unless self.#{attribute}.nil?
        self.encoded_#{attribute} = CGI::escape(self.#{attribute})
      end
            end_eval
  end
end
