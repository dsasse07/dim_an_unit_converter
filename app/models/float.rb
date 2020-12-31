class Float
  def signif(signs)
    exponent_form = sprintf("%.#{signs}g" % self)
    return Integer(Float(exponent_form)) if exponent_form[-3] == "+" || exponent_form.length == 1
    Float(exponent_form)
  end
end