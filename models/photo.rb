class Photo < Sequel::Model
  extend SoftDelete

  presenter :PhotoPresenter

  many_to_one :category

  private

  def validate
    super

    validates_presence [:id, :filename]
  end
end
