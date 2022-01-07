#!/usr/bin/env python2

from optparse import OptionParser

import serial

# https://sourceforge.net/p/pyserial/bugs/135/
TIMEOUT = None

usage = "usage: %prog [options] <serial device>"
parser = OptionParser(usage=usage)
parser.add_option("-b", "--baud", type="int", dest="baud",
                  default=115200, help="Baud rate")

(options, args) = parser.parse_args()

if len(args) != 1:
    parser.error("incorrect number of arguments")

baud = options.baud
serial_device = args[0]

# try to open the serial port by URL
try:
    serial_port = serial.serial_for_url(serial_device, baud, timeout=TIMEOUT)
# if you can't open by URL, try to open it normally
except AttributeError:
    serial_port = serial.Serial(serial_device, baud, timeout=TIMEOUT)

# flush buffers
serial_port.flushInput()
serial_port.flushOutput()

print "Attached to serial device %s at %d baud" % (serial_device, baud)
print "Waiting for incoming data..."
try:
    while True:
        c = serial_port.read() # block waiting for a single char on RX
        serial_port.write(c)   # write char back to TX
        serial_port.flush()    # flush the serial port buffers
        print "'%c' (0x%x)" % (c, ord(c))
except KeyboardInterrupt:
    serial_port.close()
