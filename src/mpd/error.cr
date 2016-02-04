require "../lib_mpd"

lib LibMPD
  fun mpd_connection_get_error(connection : Connection) : Error
  fun mpd_connection_get_error_message(connection : Connection) : UInt8*
end

module MPD
  class Error < Exception
    def self.raise_on_error(connection, message)
      return if LibMPD.mpd_connection_get_error(connection) == LibMPD::Error::Success
      mpd_error = String.new(LibMPD.mpd_connection_get_error_message(connection))
      raise new("#{message} - #{mpd_error}")
    end
  end
end
