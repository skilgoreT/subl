SUBL_DIR = "#{ENV['HOME']}/bin/pkg/Sublime\\ Text\\ 2"
SUBL_TAR = "subl_2.0.1.tar.gz"
FILES_DIR = File.expand_path(File.join(File.dirname(__FILE__),'../files'))

execute "push" do
  if platform?("ubuntu")
    dir = File.join(FILES_DIR, 'ubuntu')
    command "tar cvfz #{File.join(dir,SUBL_TAR)} #{SUBL_DIR}.app #{SUBL_DIR}"
  elsif platform?("mac_os_x")
    dir = File.join(FILES_DIR, 'mac_os_x')
    command "tar cvfz #{File.join(dir,SUBL_TAR)} #{SUBL_DIR}.app #{SUBL_DIR}"
  end
  puts Dir.chdir(File.dirname(__FILE__))
  `git commit -a -m"update subl packages and settings"`
  `{}git push -u origin master`
end
  


