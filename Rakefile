load './lib/tasks/db.rake'
load './lib/tasks/config-db.rake'
load './lib/tasks/encryption.rake'

task default: :test

desc "Start the application"
task :start do
  exec 'shotgun -s thin -r pry -o 0.0.0.0'
end

desc "Start a console"
task :console do |t, args|
  exec 'pry -r./app -r./console_helpers.rb'
end

desc 'Schedules the jobs configured in config/jobs.yml'
task :schedule_jobs do
  require_relative "app"

  jobs_schedule = YAML.load_file(File.expand_path('./config/jobs.yml'))

  Sidekiq::Cron::Job.load_from_hash jobs_schedule
end
