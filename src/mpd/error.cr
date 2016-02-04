require "../lib_mpd"

lib LibMPD
  fun mpd_connection_get_error(connection : Connection) : Error
  fun mpd_connection_get_error_message(connection : Connection) : UInt8*
end

module LibMPD
  class Error
    def initialize(connection, message)
      if mpd_connection_get_error(connection) != Error::Success
        mpd_error = String.new(LibMPD.mpd_connection_get_error_message(connection))
        super("#{message} - #{mpd_error}")
      else
        super(message)
      end
    end
  end
end
