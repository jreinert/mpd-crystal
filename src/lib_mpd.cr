@[Link("libmpdclient")]

lib LibMPD
  enum Error
    Success
  end

  enum State
    Unknown
    Stop
    Play
    Pause
  end

  @[Flags]
  enum Events
    Database       = 0x001
    StoredPlaylist = 0x002
    Queue          = 0x004
    Playlist       = Queue
    Player         = 0x008
    Mixer          = 0x010
    Output         = 0x020
    Options        = 0x040
    Update         = 0x080
    Sticker        = 0x100
    Subscription   = 0x200
    Message        = 0x400
  end

  type Connection = Void*
  type Song = Void*
  type Status = Void*
end
