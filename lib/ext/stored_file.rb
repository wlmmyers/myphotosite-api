require 'mimemagic'

module Sequel
  module Plugins
    module StoredFile
      module InstanceMethods
        def remote_name(name = nil)
          fail NotImplementedError
        end

        def file=(file)
          self.file_name = file[:filename]

          @tempfile = file[:tempfile]
        end

        def file_url
          AmazonS3.new(remote_name).url if file_name
        end

        def file_public_url
          AmazonS3.new(remote_name).public_url if file_name
        end

        private

        def upload(data)
          AmazonS3.new(remote_name).put(data)
        end

        def copy_file_to(new_name)
          AmazonS3.new(remote_name).copy_to(new_name)
        end

        def before_save
          if @tempfile && respond_to?(:mime_type=)
            self.mime_type = MimeMagic.by_magic(@tempfile).to_s
          end

          super
        end

        def after_save
          upload @tempfile if @tempfile

          super
        end

        def before_destroy
          return super() unless file_name

          delete_with_silent_failure(remote_name)

          super
        end

        def before_update
          if changed_columns.include?(:file_name)
            if !initial_value(:file_name).nil?
              old_name = remote_name(initial_value(:file_name))
              new_name = remote_name
              AmazonS3.new(old_name).rename(new_name)
            end

            if file_name.nil?
              old_name = remote_name(initial_value(:file_name))
              delete_with_silent_failure(old_name)
            end
          end

          super
        end

        def delete_with_silent_failure(object_name)
          begin
            AmazonS3.new(object_name).delete
          rescue MissingObjectError
            # do nothing because it is already deleted
          end
        end
      end
    end
  end
end
