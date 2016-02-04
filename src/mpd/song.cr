require "../lib_mpd"

lib LibMPD
  fun mpd_song_get_uri(song : Song) : UInt8*
  fun mpd_song_free(song : Song)
end

module MPD
  class Song
    def initialize(@song)
    end

    def finalize
      LibMPD.mpd_song_free(self)
    end

    def uri
      String.new(LibMPD.mpd_song_get_uri(self))
    end

    def to_unsafe
      @song
    end
  end
end
