#!/usr/bin/env bash

while $(feh --bg-fill --randomize ~/Pictures/* &)
do
	sleep 60
done &
