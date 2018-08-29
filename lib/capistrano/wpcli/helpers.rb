module Capistrano

  module Wpcli

    module Helpers

      def remote_path_arg
        fetch(:wpcli_wp_remote_dir) && "--path=#{fetch(:wpcli_wp_remote_dir)}"
      end

      def local_path_arg
        fetch(:wpcli_wp_local_dir) && "--path=#{fetch(:wpcli_wp_local_dir)}"
      end

    end

  end

end
