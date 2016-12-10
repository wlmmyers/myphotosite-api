module Memoization
  # For memoizing a method only within an instance (not across the class)
  def instance_memoize(method_name)
    memoized_method = instance_method(method_name)

    define_method(method_name) do |*args|
      # The below Hash syntax allows you to set two-deep keys at once
      @lookup ||= Hash.new { |h, k| h[k] = {} }
      return @lookup[method_name][args] if @lookup[method_name].include? args
      @lookup[method_name][args] = memoized_method.bind(self).call(*args)
    end
  end
end

