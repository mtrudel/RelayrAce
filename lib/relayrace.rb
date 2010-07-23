require 'monitor'
require 'serialport'
require 'system_timer'

class RelayrAce
  def initialize(port, logger = nil)
    @port = port
    @logger = logger
    open_serial_port
  end
  
  def close 
    @serial.close
    @serial = @port = nil
  end
  
  def get_relay(relay)
    raise "Reads aren't working yet"
  end
  
  def set_relay(relay, value)
    send_cmd("REL#{relay}.#{(value)? 'ON' : 'OFF'}")
  end
  
  def toggle_relay(relay)
    send_cmd("REL#{relay}.TOGGLE")
  end
  
  def set_all_relays(value)
    send_cmd("RELS.#{(value)? 'ON' : 'OFF'}")
  end

  def get_channel(channel)
    raise "Reads aren't working yet"
  end
  
  def set_channel(channel, value)
    send_cmd("CH#{channel}.#{(value)? 'ON' : 'OFF'}")
  end
  
  def toggle_channel(channel)
    send_cmd("CH#{channel}.TOGGLE")
  end
  
  def send_cmd(cmd)
    @serial.synchronize do
      begin
        SystemTimer.timeout_after(10) do
          @serial.write("\r\n")
          2.times { @serial.getc == ':' }
          @serial.write("#{cmd}\r\n")
        end
      rescue Timeout::Error
        @logger.warn "Reopening serial port due to timeout" if @logger
        open_serial_port
      end
    end
  end  
  
  private
  def open_serial_port
    @serial.close if @serial
    sleep 1 # Give the OS a chance to catch up
    @serial = SerialPort.new(@port, 115200, 8, 1, SerialPort::NONE)
    @serial.extend(MonitorMixin)
  end
end
