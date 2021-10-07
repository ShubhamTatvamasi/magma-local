#!/usr/bin/env bash

for i in fluentd master.nms api controller bootstrapper-controller
do
  host ${i}.${1}
done
