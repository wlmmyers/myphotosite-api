module SoftDelete
  def self.extended(base)
    base.class_eval do
      plugin :paranoid, enable_default_scope: true, deleted_column_default: Time.at(0)

      dataset_module do
        def include_deleted(bool = false)
          bool ? with_deleted : present
        end
      end
    end
  end
end
