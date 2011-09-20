#!/usr/bin/env ruby
require 'lib/gem_fetcher'
require 'curb'

resp = Curl::Easy.perform("https://raw.github.com/phuong-nguyen/Gem-Caching-Server/master/gem_list")
gems = resp.body_str.split("\n").map(&:strip)
gems.reverse.each do |gem|
  unless gem == ""
    puts "Updating #{gem}"
    GemFetcher.update(gem)
  end
end
