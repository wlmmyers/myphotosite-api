require_relative 'standard_error'
require_relative '../memoization'

class Sequel::Model
  extend Memoization

  class NotImplementedError < StandardError
    key :not_implemented
    message 'This method needs to be implemented by a sub class.'
  end

  dataset_module do
    def by_id(id)
      where(id: id).first
    end

    def paginate(length = 10, offset = 0)
      limit(length, offset)
    end
  end

  def self.presenter(presenter_sym = :Presenter)
    @presenter_sym ||= presenter_sym
  end

  def self.presenter_class
    @presenter_class ||= Object.const_get(presenter)
  end

  instance_memoize def presenter(options = {})
    self.class.presenter_class.new self, options
  end

  def self.validator(validator_class = Validator)
    @validator_class ||= validator_class
  end

  def validator(options = {})
    @validator ||= self.class.validator.new self, options
  end

  def to_json(options = {})
    if options.is_a? Hash
      presenter(options).to_json
    else
      presenter.to_json(options)
    end
  end
end
