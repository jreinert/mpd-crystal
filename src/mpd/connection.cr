require "./status"
require "../lib_mpd"
require "./idler"
require "./error"

lib LibMPD
  fun mpd_connection_new(host : UInt8*, port : UInt32, timeout : UInt32) : Connection?
end

module MPD
  alias Events = LibMPD::Events

  class Connection
    class Error < MPD::Error
    end

    def initialize(host = nil : String?, port = 0 : Int32, timeout = 0.milliseconds : Time::Span)
      connection, listener = (0..1).map {
        LibMPD.mpd_connection_new(
          host.try { |h| h.to_unsafe } || Pointer(UInt8).null,
          port.to_u32,
          timeout.milliseconds
        )
      }
      raise "Out of memory" unless connection && listener
      @connection = connection

      [connection, listener].each do |c|
        Error.raise_on_error(c, "failed to connect to mpd")
      end

      @idler = Idler.new(listener)
    end

    def on_event(event_mask, &block : Events ->)
      @idler.on_event(event_mask, &block)
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
