# encoding: UTF-8
# Tasks for converting TEI XML

require 'curb'
require 'nokogiri'
require 'active_support'
require 'uri'

SWINBURNE_PATH = File.expand_path('./lib/assets/swinburne.xml')

task :reset => ['db:reset', 'db:migrate']

def check_file
  unless File.exist?(SWINBURNE_PATH)
    puts `rake remote:fetch`
  end
end

def load_file
  @doc = Nokogiri::XML(File.open(SWINBURNE_PATH))
  @doc.remove_namespaces!
end

def parse_url(url)
  uri = URI(url)
  "#{uri.scheme}://#{uri.host}#{uri.path}"
end

def url_name(url)
  uri = URI(url)
  uri.path
end

def poem_helper(title = nil, node)
  image = @available_images.sample
  xml = Nokogiri::XML(node)

  if title.nil?
    title = '' # parse from node
  end

  puts "Adding #{title}"

  Poem.create(
    title: title,
    image: image.gsub('./public', ''),
    content: @xslt.transform(node).to_html
  )
  @available_images.delete(image)

end

def clean_title(string)
  string.strip.gsub('                    ', '').gsub(/[.\*]/i, '').humanize.titleize
end

namespace :convert do

  desc 'Generate poems from XML'
  task :poems => :reset do
    check_file
    load_file

    @available_images = Dir['./public/assets/images/*']
    @xslt = Nokogiri::XSLT(File.read(File.expand_path('./lib/assets/poems.xsl')))

    title_page_image = @available_images.sample

    # really special case
    Poem.create(
      title: 'Ballads and Poems <span>Algernon Charles Swinburne</span>',
      image: title_page_image.gsub('./public', ''),
      content: ''
    )
    @available_images.delete(title_page_image)

    # special case
    front_node = Nokogiri::XML(@doc.xpath('/TEI/text/front').to_xml)
    poem_helper('Front', front_node)

    # adds each poem
    @doc.xpath('/TEI/text/body/div[@type="poem"]').each do |poem|
      title = poem.at('div//head[@type="poem"]')
      unless title.nil?
        scrubbed_title = clean_title(title.content)
        node = Nokogiri::XML(poem.to_xml)
        poem_helper(scrubbed_title, node)
      end
    end

    # special case back
    back_node = Nokogiri::XML(@doc.xpath('/TEI/text/back').to_xml)
    poem_helper('Back', back_node)

  end

  desc 'Get dummy images from unsplash.com'
  task :images => :environment do
    base = 'https://unsplash.com'
    a = Mechanize.new
    page = a.get(base)
    counter = 0

    loop do
      page.images.each do |image|
        url = parse_url(image.src) unless image.src.include? '.svg'
        a.get(url).save File.expand_path("public/assets/images/#{url_name(image.src)}.jpg") unless image.src.include? '.svg'
      end

      break unless (counter == 8 || link = page.link_with(:text => 'Next →'))
      page = link.click
      puts counter
      counter += 1

    end
    #a.get(base) do |page|
    #page.images.each do |image|
    #puts parse_url(image.src) unless image.src.include? '.svg'
    #end
    #end
  end
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
    path = File.expand_path('./lib/assets/swinburne.xml')
    File.open(path, 'w') {|file| file.write(response.body_str)}

  end
end
