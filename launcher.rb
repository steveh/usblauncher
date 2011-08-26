require "usb"

class Launcher

  VENDOR  = 0x2123
  PRODUCT = 0x1010

  DOWN  = 0x01
  UP    = 0x02
  LEFT  = 0x04
  RIGHT = 0x08

  FIRE = 0x10
  STOP = 0x20

  def initialize
    find_device_by_vendor_and_product(VENDOR, PRODUCT)
  end

  def down(duration = 1000)
    send_move(DOWN, duration)
  end

  def up(duration = 1000)
    send_move(UP, duration)
  end

  def left(duration = 1000)
    send_move(LEFT, duration)
  end

  def right(duration = 1000)
    send_move(RIGHT, duration)
  end

  def fire(num_projectiles = 1)
    # Stabilise prior to the shot
    sleep 0.5
    num_projectiles.times do
      send_command(FIRE)
      # Allow for reloading
      sleep 4.5
    end
  end

  def zero
    send_move(DOWN, 2000)
    send_move(LEFT, 8000)
  end

  def pause(duration)
    sleep(duration / 1000.0)
  end

  private

    def find_device_by_vendor_and_product(vendor, product)
      @device = USB.devices.detect{ |device| device.idVendor == vendor && device.idProduct == product }

      raise "Launcher not found" unless @device
    end

    def send_command(command)
      @device.open do |handle|
        request_type = 0x21
        request      = 0x09
        value        = 0
        index        = 0
        bytes        = [0x02, command, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00].pack("c*")
        timeout      = 1000

        result = handle.usb_control_msg(request_type, request, value, index, bytes, timeout)

        result
      end
    end

    def send_move(direction, duration)
      send_command(direction)
      pause(duration)
      send_command(STOP)
    end

end
