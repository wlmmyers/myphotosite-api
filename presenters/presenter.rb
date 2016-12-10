class Presenter
  def initialize(object, options = {})
    @object, @options = object, options

    @options[:validations] = @options[:validations].to_bool
  end

  def to_json(options = {})
    attributes.to_json
  end

  def attributes
    @object.to_hash.merge!(validations)
  end

  private

  def validations
    return {} unless @options[:validations].to_bool

    validator = @object.validator(shallow: true)

    validator.valid? ? {} : { errors: validator.errors }
  end

  def current_user
    @options[:_current_user]
  end

  def admin_user?
    current_user && current_user.admin_access?
  end
end
