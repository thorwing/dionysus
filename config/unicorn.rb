root = "/home/deployer/apps/dionysus/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.dionysus.sock"
worker_processes 2
timeout 30