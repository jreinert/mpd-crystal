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

  type Connection = Void*
  type Song = Void*
  type Status = Void*
end
