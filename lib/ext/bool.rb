# in case a `#to_bool` gets chained too many times, these extensions will help
class TrueClass
  def to_bool
    self
  end
end

class FalseClass
  def to_bool
    self
  end
end

class NilClass
  def to_bool
    false
  end
end
