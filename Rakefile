load './lib/tasks/encryption.rake'

task default: :test

desc "Start the application"
task :start do
  exec 'shotgun -p 9000'
end

desc "Start a console"
task :console do |t, args|
  exec 'pry -r./app'
end

desc 'Schedules the jobs configured in config/jobs.yml'
task :schedule_jobs do
  require_relative "app"

  jobs_schedule = YAML.load_file(File.expand_path('./config/jobs.yml'))

  Sidekiq::Cron::Job.load_from_hash jobs_schedule
end
