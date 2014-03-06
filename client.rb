require "json"
require "uri"
require "open-uri"
require "logger"
require "pi_piper"

include PiPiper

STATUS_URL = "https://traffic-light-server.herokuapp.com/lights"

# will be filled with first response
@colors = {}

@pins = {
  "red"    => PiPiper::Pin.new(:pin => 17, :direction => :out),
  "yellow" => PiPiper::Pin.new(:pin => 27, :direction => :out),
  "green"  => PiPiper::Pin.new(:pin => 22, :direction => :out)
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
