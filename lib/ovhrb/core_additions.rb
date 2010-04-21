class String
  def camelize(first_letter = :lower)
    if first_letter != :lower
      gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
    else
      self[0].chr.downcase + camelize(self)[1..-1]
    end
  end
  
  def constantize
    unless /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/ =~ self
      raise NameError, "#{camel_cased_word.inspect} is not a valid constant name!"
    end
    
    Object.module_eval("::#{$1}", __FILE__, __LINE__)
  end
  
  def underscore
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').gsub(/([a-z\d])([A-Z])/,'\1_\2').tr("-", "_").downcase
  end
  
  def humanize
    gsub(/_/, " ").capitalize
  end

  def titleize
    underscore.humanize.gsub(/\b('?[a-z])/) { $1.capitalize }
  end
end
