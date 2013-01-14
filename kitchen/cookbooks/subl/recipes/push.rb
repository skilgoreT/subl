require File.expand_path(File.join(File.dirname(__FILE__), 'subl'))

SUBL_TAR = "subl_2.0.1.tar"
SUBL_USR_TAR = "subl_usr.tar"
FILES_DIR = File.expand_path(File.join(File.dirname(__FILE__),'../files'))
USR_TAR_DIR = File.join(FILES_DIR, 'default')
SUBL_USR_TARBALL = File.join(USR_TAR_DIR, SUBL_USR_TAR)

if platform?("ubuntu")
    SUBL_USR = "sublime-text-2"
    SUBL_APP = "Sublime\\ Text\\ 2"
    TAR_DIR = File.join(FILES_DIR, 'ubuntu')
	TARBALL = File.join(TAR_DIR, SUBL_TAR)
	APP_DIR = File.join(ENV['HOME'], 'bin')
	USR_DIR = File.join(ENV['HOME'], '.config', SUBL_USR)
elsif platform?("mac_os_x")
    SUBL_USR = "Sublime\\ Text\\ 2"
    SUBL_APP = "Sublime\\ Text\\ 2.app"
	TAR_DIR = File.join(FILES_DIR, 'mac_os_x')
	TARBALL = File.join(TAR_DIR, SUBL_TAR)
	APP_DIR = File.join('', 'Applications')
	USR_DIR = File.join(ENV['HOME'], 'Library', 'Application\\ Support', SUBL_USR)
end

Subl.with_logging(cmd = "tar cfz #{TARBALL} -C #{APP_DIR} #{SUBL_APP}") {system cmd}
Subl.with_logging(cmd = "tar cfz #{SUBL_USR_TARBALL} -C #{USR_DIR} .") {system cmd}
Subl.with_logging(cmd = "cd #{File.dirname(__FILE__)}; git commit -a -m'update subl packages and settings'; git push") {system cmd}





