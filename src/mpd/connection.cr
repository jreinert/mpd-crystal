require "./status"
require "../lib_mpd"

lib LibMPD
  fun mpd_connection_new(host : UInt8*, port : UInt32, timeout : UInt32) : Connection?
  fun mpd_connection_get_error(connection : Connection) : Error
  fun mpd_connection_get_error_message(connection : Connection) : UInt8*
end

module MPD
  class Connection
    class Error < Exception
      def initialize(connection : Connection)
        message = String.new(LibMPD.mpd_connection_get_error_message(connection))
        super(message)
      end

      def initialize(message : String)
        super(message)
      end
    end

    def initialize(host = nil : String?, port = 0 : Int32, timeout = 0.milliseconds : Time::Span)
      connection = LibMPD.mpd_connection_new(
        host.try { |h| h.to_unsafe } || Pointer(UInt8).null,
        port.to_u32,
        timeout.milliseconds
      )
      raise Error.new("Out of memory") unless connection
      @connection = connection

      if LibMPD.mpd_connection_get_error(self) != LibMPD::Error::Success
        raise Error.new(self)
      end
    end

    def status
      Status.new(self)
    end

    def player
      Player.new(self)
    end

    def to_unsafe
      @connection
    end
  end
end
