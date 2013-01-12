module Subl

  class << self

    def with_logging(cmd)
      begin
        Chef::Log.info(cmd) 
        yield
      rescue
        Chef::Log.error("Error: #{cmd} failed")
        raise
      end
    end

  end 
end 