# frozen_string_literal: true

module Ftpd

  require 'uuid'

  # A disk file system that does not allow any modification (writes,
  # deletes, etc.)

  class UniqueFileNamesDiskFileSystem

    include DiskFileSystem::Base
    include DiskFileSystem::List
    include DiskFileSystem::Read
    include DiskFileSystem::Write

    def write(ftp_path, stream)
      uuid = UUID.new.generate
      timestamp = Time.now.strftime('%Y%m%d%H%M%S')
      write_file "#{ftp_path}.#{timestamp}.#{uuid}", stream, 'wb'
    end

    # Make a new instance to serve a directory.  data_dir should be an
    # absolute path.

    def initialize(data_dir)
      set_data_dir data_dir
      translate_exception SystemCallError
    end

  end

end
