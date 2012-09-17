String.class_eval do
  def unhtml
    self.gsub(/<\/?[^>]*>/, "")
  end
end