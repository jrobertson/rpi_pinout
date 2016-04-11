#!/usr/bin/env ruby

# file: rpi_pinout.rb


HIGH = 1
LOW = 0


class RPiPinOut
  
  def initialize(id)

    @id = id    
    unexport()
    
    File.write '/sys/class/gpio/export', id
    File.write "/sys/class/gpio/gpio#{id}/direction", 'out'

    at_exit {   unexport() }
    
  end

  def on(duration=nil)

    set_pin HIGH; 
    @state = :on
    (sleep duration; self.off) if duration
  end

  def off(duration=nil)

    return if self.off?
    set_pin LOW      
    @state = :off
    (sleep duration; self.on) if duration
  end
  
  alias high on # opposite of low
  alias open on # opposite of close
  alias lock on # opposite of unlock
  
  alias stop off        
  alias low off
  alias close off
  alias unlock off

  def blink(seconds=0.5, duration: nil)

    @state = :blink
    t2 = Time.now + duration if duration

    Thread.new do
      while @state == :blink do
        (set_pin HIGH; sleep seconds; set_pin LOW; sleep seconds) 
        self.off if duration and Time.now >= t2
      end
      
    end
  end
  
  alias oscillate blink

  def on?()  @state == :on  end
  def off?() @state == :off end

  # set val with 0 (off) or 1 (on)
  #
  def set_pin(val)

    state = @state
    File.write "/sys/class/gpio/gpio#{@id}/value", val
    @state = state
    
  end
  
  def to_s()
    @id
  end
  
  private
  
  # to avoid "Device or resource busy @ fptr_finalize - /sys/class/gpio/export"
  # we unexport the pins we used
  #
  def unexport()
    
    return unless File.exists? '/sys/class/gpio/gpio' + @id.to_s

    File.write "/sys/class/gpio/unexport", @id
  end
end