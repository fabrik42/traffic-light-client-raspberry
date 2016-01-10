# Traffic Light client for the Raspberry PI

![traffic light at the flinc office](http://i.imgur.com/3ZX9R.jpg)

This is a little ruby script that corresponds to our [Traffic Light Server](https://github.com/fabrik42/traffic-light-server) and controls the lights of a modded traffic light, using three GPIO pins of the Raspberry PI.

This project has been tested on Raspbian.

# Installation

This client uses the [pi_piper](https://github.com/jwhitehorn/pi_piper) gem, so head over there for installation instructions. Hint: you will need to install the ruby dev packages `sudo apt-get install -y ruby-dev`.

Besides this lib, the client only uses Ruby's core and stdlib.

# Usage

Start with `sudo ruby client.rb` (you need sudo rights to access the pins of the Raspberry Pi).
The client will run in the background.




========================

:traffic_light: :heart: :traffic_light:
