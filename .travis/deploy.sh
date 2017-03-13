#!/bin/bash

gem install gems -v 1.0.0
gem install dpl -v 1.8.31
dpl --provider=rubygems --api-key=$RUBY_GEMS_API_KEY --gemspec=./rrj.gemspec
