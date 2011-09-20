#!/bin/bash
cd `dirname $0`
./resync.rb
gem generate_index --update
