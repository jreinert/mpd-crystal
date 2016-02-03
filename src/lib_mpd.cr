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
    Database = 0x1
    StoredPlaylist = 0x2
    Queue = 0x4
    Player = 0x8
    Mixer = 0x10
    Output = 0x20
    Options = 0x40
    Update = 0x80
    Sticker = 0x100
    Subscription = 0x200
    Message = 0x400
  end

  type Connection = Void*
  type Song = Void*
  type Status = Void*
end
