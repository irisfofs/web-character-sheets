
namespace :test do
  task :ci do
    Rake::Task["db:test:prepare"].clear_prerequisites
    Rake::Task["db:test:load"].invoke
    Rake::Task["spec"].invoke
  end
end
