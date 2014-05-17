set :stage, :production
set :rails_env, :production
server 'www.yato-extreme.com', :roles => [:web, :app, :db], :ssh_options => {
  :keys => %w(~/.ssh/id_rsa),
  :forward_agent => false,
  :auth_methods => %w(publickey password),
  :port => 5555,
  :user => "nreynen"
}, :default => true