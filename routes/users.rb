class UserRoutes < PhotositeServerBase
  # Create new tenant database from an existing template db
  post "/" do
    # Sanitize user input
    tenant = Shellwords.escape params[:tenant]
    if tenant

      # TODO check for existence of tenant name
      # TODO add user to `_config` tenants table
      # TODO create admin user for tenant

      # Create database
      create_status = system "mysql -u #{ENV['API_DB_USER']} --password=#{ENV['API_DB_PASS']} -e \"create database #{tenant}\""

      # Duplicate template database into new user database
      dup_status = system "mysqldump -u #{ENV['API_DB_USER']} --password=#{ENV['API_DB_PASS']} template | mysql -u #{ENV['API_DB_USER']} --password=#{ENV['API_DB_PASS']} -h #{ENV['API_DB_HOST']} #{tenant}"

      halt create_status && dup_status ? 200 : 500
    else
      halt 422, body: { errors: 'Missing tenant name' }
    end
  end
end
