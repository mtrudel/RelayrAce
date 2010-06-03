require 'monitor'
require 'serialport'

class RelayrAce
  
  Version = '0.0.2'

  attr_reader :port

  def initialize(port)
    @port = port
    @serial = SerialPort.new(port, 115200)
    @serial.extend(MonitorMixin)
  end
  
  def close 
    @serial.close
    @serial = @port = nil
  end
  
  def get_relay(relay)
    send_cmd("REL#{relay}.GET")
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
    send_cmd("CH#{channel}.GET")
  end
  
  def set_channel(channel, value)
    send_cmd("CH#{channel}.#{(value)? 'ON' : 'OFF'}")    
  end
  
  def toggle_channel(channel)
    send_cmd("CH#{channel}.TOGGLE")
  end
  
  def send_cmd(cmd)
    @serial.synchronize do
      @serial.write("\r\n#{cmd}\r\n")
      @serial.read
    end
  end
end
