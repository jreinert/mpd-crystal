require "./connection"
@[Link("libmpdclient")]

lib LibMPD
  type Song = Void*

  fun mpd_run_current_song(connection : Connection)
  fun mpd_song_get_uri(song : Song) : UInt8*
end

module MPD
  class Song
    def initialize(@song)
    end

    def uri
      LibMPD.mpd_song_get_uri(self)
    end

    def to_unsafe
      @song
    end
  end
end
