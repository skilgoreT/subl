cookbook_file File.join(ENV['HOME'], '.bash_profile') do
  owner ENV['SUDO_USER']
  group 'staff'
  mode 0644
  source "bash_profile"
end

cookbook_file File.join(ENV['HOME'], '.bash_profile') do
  owner ENV['SUDO_USER']
  group 'staff'
  mode 0644
  source "bash_profile"
end

cookbook_file File.join(ENV['HOME'], '.bash_aliases') do
  owner ENV['SUDO_USER']
  group 'staff'
  mode 0644
  source "bash_aliases"
end

remote_directory File.join(ENV['HOME'], 'bin') do
  files_backup 0
  files_owner ENV['SUDO_USER']
  files_group 'staff'
  files_mode 0755
  source "bin"
end



  