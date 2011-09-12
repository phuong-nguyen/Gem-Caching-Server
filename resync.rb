#!/usr/bin/env ruby
require 'lib/gem_fetcher'

gems = File.read('gem_list').split("\n").map(&:strip)
gems.each do |gem|
  puts "Updating #{gem}"
  GemFetcher.update(gem)
end
