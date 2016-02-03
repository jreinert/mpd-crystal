require "../spec_helper"

module MPD
  describe Connection do
    it "establishes a connection to a running mpd server" do
      Connection.new
    end
  end
end
