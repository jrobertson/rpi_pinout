#!/usr/bin/env ruby

# file: rpi_pinout.rb

require 'pinx'


class RPiPinOut < PinX
  
  def initialize(id)
    
    super(id)
    @id = id    
    unexport()
    
    File.write '/sys/class/gpio/export', id
    File.write "/sys/class/gpio/gpio#{id}/direction", 'out'

    at_exit {   unexport() }
    
  end

  
  protected

  def set_pin(val)

    super(val)
    File.write "/sys/class/gpio/gpio#{@id}/value", (val ? 1 : 0)
    
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