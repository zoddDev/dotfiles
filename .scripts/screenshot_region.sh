#!/bin/bash

import /tmp/screenshot.png && cat /tmp/screenshot.png | xclip -sel clip -t image/png
