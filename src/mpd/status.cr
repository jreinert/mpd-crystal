require "./connection"
require "./song"
require "../lib_mpd"
require "./error"

lib LibMPD
  fun mpd_send_status(connection : Connection) : Bool
  fun mpd_recv_status(connection : Connection) : Status
  fun mpd_status_get_state(status : Status) : State
  fun mpd_status_get_song_id(status : Status) : Int32
  fun mpd_status_get_elapsed_ms(status : Status) : UInt32
  fun mpd_status_free(status : Status)
end

module MPD
  class Status
    class Error < MPD::Error
    end

    def initialize(connection)
      LibMPD.mpd_send_status(connection)
      Error.raise_on_error(connection, "failed sending status command")
      status = LibMPD.mpd_recv_status(connection)
      Error.raise_on_error(connection, "failed receiving status")
      @status = status
    end

    def finalize
      LibMPD.mpd_status_free(self)
    end

    {% for state in LibMPD::State.constants %}
      def {{state.stringify.downcase.id}}?
        state == LibMPD::State::{{state}}
      end
    {% end %}

    def elapsed
      LibMPD.mpd_status_get_elapsed_ms(self).milliseconds
    end

    def to_unsafe
      @status
    end

    private def state
      LibMPD.mpd_status_get_state(self)
    end
  end
end
