require "./connection"
require "./song"
require "../lib_mpd"

lib LibMPD
  fun mpd_run_current_song(connection : Connection)
end

module MPD
  class Player
    def intialize(@connection)
    end

    def current_song
      song = LibMPD.mpd_run_current_song(@connection)
      return unless song
      Song.new(song)
    end
  end
end
