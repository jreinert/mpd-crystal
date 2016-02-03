require "../lib_mpd"

lib LibMPD
  fun mpd_run_idle(connection : Connection) : Events
end

module MPD
  class Idler
    def initialize(@connection)
      @id_counter = 0_u32
      @subscribers = {} of UInt32 => { Events, Channel::Unbuffered(Events) }
      spawn event_loop
    end

    def on_event(event_mask)
      channel = Channel(Events).new
      id = @id_counter
      @id_counter += 1

      @subscribers[id] = { event_mask, channel }
      yield channel.receive
      @subscribers.delete(id)
    end

    private def event_loop
      loop do
        event = LibMPD.mpd_run_idle(@connection)
        @subscribers.each do |mask_channel|
          mask, channel = mask_channel
          channel.send(event) if mask & event
        end
      end
    end
  end
end
