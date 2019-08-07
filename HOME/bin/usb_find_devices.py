#!/usr/bin/env python

import os
import usb.core

# only needed for MacPorts
# os.environ['DYLD_FALLBACK_LIBRARY_PATH'] = '/opt/local/lib'

os.environ['PYUSB_DEBUG'] = 'debug'
print(usb.core.find())
