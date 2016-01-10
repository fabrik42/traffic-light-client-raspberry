require "json"
require "uri"
require "open-uri"
require "logger"
require "pi_piper"

include PiPiper

at_exit do
  puts "cleaning up registered GPIO pins..."
  puts `echo 13 >/sys/class/gpio/unexport`
  puts `echo 19 >/sys/class/gpio/unexport`
  puts `echo 26 >/sys/class/gpio/unexport`
end

STATUS_URL = "https://traffic-light-server.herokuapp.com/lights"

# will be filled with first response
@colors = {}

@pins = {
  "red"    => PiPiper::Pin.new(:pin => 13, :direction => :out),
  "yellow" => PiPiper::Pin.new(:pin => 19, :direction => :out),
  "green"  => PiPiper::Pin.new(:pin => 26, :direction => :out)
}

@log = Logger.new("output.log")
@log.level = Logger::INFO

Process.daemon(true)

def get_lights
  response = URI.parse(STATUS_URL).read
  JSON.parse(response)
end

def set_light(color, state)
  return if @colors[color] == state

  if state == true
    @pins[color].on
  else
    @pins[color].off
  end

  @log.info "#{color} => #{state}"
  @colors[color] = state
end

while true do
  lights = get_lights

  ["red", "yellow", "green"].each do |color|
    set_light(color, !!lights[color])
  end

  sleep 2
end
