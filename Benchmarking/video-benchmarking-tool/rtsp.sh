#!/bin/bash -e

# Copyright (c) 2020 Intel Corporation.

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

RTSP_PORT=$1
BIT_RATE=$2
WIDTH=$3
HEIGHT=$4
FRAMERATE=$5


GSTREAMER_PIPE="videotestsrc ! videoscale ! video/x-raw,width=$WIDTH,height=$HEIGHT ! videorate ! video/x-raw,framerate=$FRAMERATE/1 ! x264enc speed-preset=superfast bitrate=$BIT_RATE ! rtph264pay name=pay0 pt=96"
echo $GSTREAMER_PIPE
docker run -d --rm  -e RTSP_PORT=$RTSP_PORT -e GST_PIPELINE="$GSTREAMER_PIPE" -p $RTSP_PORT:$RTSP_PORT --name rtsp_$RTSP_PORT ullaakut/rtspatt:1.3.2