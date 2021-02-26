#!/bin/bash

WORKSPACE_BUFFER="$(cat ~/.config/last-workspace-buffer)"
wmctrl -s $WORKSPACE_BUFFER
