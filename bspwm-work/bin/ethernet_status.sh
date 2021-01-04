#!/bin/sh

echo "%{F#2495e7} %{F#e2ee6a}$(/sbin/ifconfig enp2s0 | grep "inet " | awk '{print $2}')%{u-}"
