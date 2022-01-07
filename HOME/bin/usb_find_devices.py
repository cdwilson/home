#!/usr/bin/env python

import sys
import os
import usb.core

if sys.platform == "darwin":
    os.environ["DYLD_FALLBACK_LIBRARY_PATH"] = "/opt/homebrew/lib/:/usr/local/lib:/opt/local/lib"

os.environ['PYUSB_DEBUG'] = 'debug'
print(usb.core.find())
