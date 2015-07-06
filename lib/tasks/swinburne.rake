# encoding: UTF-8
# Tasks for converting TEI XML

require 'curb'

namespace :convert do
end

namespace :remote do

  desc 'Fetch the latest TEI edition from GitHub repo'
  task :fetch do
    puts "Downloading lastest version of the Swinburne edition from Github (master branch)"
    puts "This will take a second..."

    uri = "https://raw.githubusercontent.com/nowviskie/Swinburne/master/xml/base2-tm.xml"

    response = Curl::Easy.http_get(uri) do |c|
      c.on_complete do |curl_response|
        encoding = 'UTF-8'
        encoding = $1 if curl_response.header_str =~ /charset=([-a-z0-9]+)/i
        encoding = $1 if curl_response.body_str =~ %r{<meta[^>]+content=[^>]*charset=([-a-z0-9]+)[^>]*>}mi
        curl_response.body_str.force_encoding(encoding)
      end
    end

    puts "Writing to lib/assets/swinburne.xml"
    path = File.expand_path('./lib/assets') + '/swinburne.xml'
    File.open(path, 'w') {|file| file.write(response.body_str)}

  end
end
