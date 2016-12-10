class Category < Sequel::Model
  extend SoftDelete

  # many_to_one :item
  one_to_many :photos

  private

  def validate
    super

    validates_presence [:id, :title]
  end
end
