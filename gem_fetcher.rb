require 'rubygems'
require 'nokogiri'
require 'curb'
require 'ruby-debug'
class GemFetcher
  REMOTE_SERVER = "rubygems.org"
  class << self
    def version_list(gem)
      resp = Curl::Easy.perform("http://#{REMOTE_SERVER}/gems/#{gem}/versions")
      doc = Nokogiri::HTML(resp.body_str)
      doc.css('.info .versions a')[0..4].map do |link|
        link.content
      end
    end

    def download_gem(gem, version, target = 'gems')
      path = "#{target}/#{gem}-#{version}.gem"
      unless File.exists?(path)
        File.open(path, "wb") do |f|
          url = "http://#{REMOTE_SERVER}/downloads/#{gem}-#{version}.gem"
          curl = Curl::Easy.new(url) do |curl|
            curl.follow_location = true
          end
          curl.perform
          f.write curl.body_str
        end
        true
      else
        false
      end
    end
  end
end
