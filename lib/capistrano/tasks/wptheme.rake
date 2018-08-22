namespace :load do

  task :defaults do

    # These options are passed directly to rsync
    # Append your options, overwriting the defaults may result in malfunction
    # Ex: --recursive --delete --exclude .git*
    set :wpcli_rsync_options, "-avz --rsh=ssh --progress"

    # Local dir where WP stores the compiled theme's dist folder
    # IMPORTANT: Add trailing slash!
    set :wpcli_local_theme_dist_dir, "web/app/themes/sage/dist/"

    # Remote dir where WP stores the theme's dist folder
    # IMPORTANT: Add trailing slash!
    set :wpcli_remote_theme_dist_dir, -> {"#{current_path.to_s}/web/app/themes/sage/dist/"}

  end

end

namespace :wpcli do
  namespace :theme do
#    namespace :rsync do

      desc "Push local theme dist delta to remote machine"
      task :push do
        roles(:web).each do |role|
          puts role.netssh_options[:port]
          port = role.netssh_options[:port] || 22
          set :wpcli_rsync_options, fetch(:wpcli_rsync_options) + (" -e 'ssh -p #{port}'")
          run_locally do
            execute :rsync, fetch(:wpcli_rsync_options), fetch(:wpcli_local_theme_dist_dir), "#{role.user}@#{role.hostname}:#{fetch(:wpcli_remote_theme_dist_dir)}"
          end
        end
      end

      desc "Pull remote theme dist delta to local machine"
      task :pull do
        roles(:web).each do |role|
          run_locally do
            execute :rsync, fetch(:wpcli_rsync_options), "#{role.user}@#{role.hostname}:#{fetch(:wpcli_remote_theme_dist_dir)}", fetch(:wpcli_local_theme_dist_dir)
          end
        end
      end
#    end
  end
end
