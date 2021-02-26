#!/bin/bash

WORKSPACE_REGISTRY=$HOME/.config/last-workspace
WORKSPACE_BUFFER=$HOME/.config/last-workspace-buffer

# Getters

function get_registry_content {
    cat $WORKSPACE_REGISTRY
}

function get_buffer_content {
    cat $WORKSPACE_BUFFER
}

function get_current_workspace {
    echo "$(wmctrl -d | grep "*" | cut -d ' ' -f 1)"
}

function get_last_workspace {
    get_registry_content
}

# Functionality

function update_last_workspace {
    echo "UPDATING {current=$(get_current_workspace), last=$(get_last_workspace)}"
    
    PRE=$(get_last_workspace)

    # write the current workspace into the registry
    get_current_workspace > $WORKSPACE_REGISTRY

    # write PRE value into the buffer
    echo $PRE > $WORKSPACE_BUFFER
}

function check {
    echo "REGISTRY=$(get_registry_content) | BUFFER=$(get_buffer_content)"

    if [[ $(get_current_workspace) -ne $(get_last_workspace) ]] 
    then
        # workspace switch detected
        update_last_workspace
    fi
}

[ -f $WORKSPACE_REGISTRY ] || touch $WORKSPACE_REGISTRY
[ -f $WORKSPACE_BUFFER ] || touch $WORKSPACE_BUFFER && echo '' > $WORKSPACE_BUFFER

get_current_workspace > $WORKSPACE_REGISTRY

while true
do 
    check
    sleep 0.075
done
