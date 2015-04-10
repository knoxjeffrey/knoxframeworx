class String
  
  def to_snake_case
    self.gsub("::", '/').
          gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').  #FOOBar becomes foo_bar
          gsub(/([a-z\d])([A-Z])/, '\1_\2').      #FO86OBar becomes fo86_o_bar
          tr('-', '_').
          downcase
  end
  
  def to_camel_case
    return self if self !~ /_/ && self =~ /[A-Z]+.*/    #return if has underscor and starts with capital
    split('_').map { |str| str.capitalize }.join        #else foo_bar will become FooBar
  end
end