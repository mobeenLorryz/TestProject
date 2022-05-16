role :app, %w{ubuntu@18.237.28.70}
role :web, %w{ubuntu@18.237.28.70}
role :db, %w{ubuntu@18.237.28.70}
role :background, %w{ubuntu@18.237.28.70}
#set :ubuntu_to, '/home/ubuntu/lorryz-backend/'
#set :deploy_to, '/var/www/TestProject/'
set :rvm_ruby_version, '2.4.2'
#set :branch, 'staging'
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

set :application, "TestProject"
set :repo_url, "git@github.com:mobeenLorryz/TestProject.git"

set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix:///tmp/puma.sock"    #accept array for multi-bind
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"

set :delayed_job_workers, 1
set :delayed_job_roles, [:app, :background]

server '18.237.28.70', user: 'ubuntu', roles: %w{web app}, my_property: :my_value
server '18.237.28.70',
       user: 'ubuntu',
       roles: %w{web app},
       ssh_options: {
           user: 'ubuntu', # overrides user setting above
           keys: %w(/home/ravian/ubunu.pem),
           forward_agent: true,
           auth_methods: %w(publickey)
       }
namespace :paths do
  desc "Link paths of required files"
  task :link_paths do
    run "ln -sf #{shared_path}/uploads #{release_path}/public/uploads"
  end
end


# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "example.com", user: "ubuntu", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "ubuntu", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "ubuntu", roles: %w{db}



# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{ubuntu@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{ubuntu@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/ubuntu.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server "example.com",
#   user: "user_name",
#   roles: %w{web app},
#   ssh_options: {
#     user: "user_name", # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }