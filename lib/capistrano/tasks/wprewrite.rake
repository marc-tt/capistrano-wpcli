namespace :load do

  task :defaults do

    # WP release path
    set :wpcli_wp_release_path, -> { release_path }

  end

end

namespace :wpcli do
  namespace :rewrite do
    desc "Flush rewrite rules."
    task :flush do
      on roles(:web) do
        within fetch(:wpcli_wp_release_path) do
          execute :wp, :rewrite, :flush, fetch(:wpcli_args)
        end
      end
    end

    desc "Perform a hard flush - update `.htaccess` rules as well as rewrite rules in database."
    task :hard_flush do
      on roles(:web) do
        within fetch(:wpcli_wp_release_path) do
          execute :wp, :rewrite, :flush, "--hard", fetch(:wpcli_args)
        end
      end
    end
  end
end