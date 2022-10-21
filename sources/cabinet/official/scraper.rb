#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

# override to force to UTF-8
class LocalFileRequest < Scraped::Request::Strategy
  def response
    { body: Pathname.new(url).read.force_encoding("windows-1252").encode('UTF-8') }
  end
end

class MemberList
  class Member
    field :name do
      noko.css('h4').text.tidy
    end

    field :position do
      noko.css('.desc').text.tidy
    end
  end

  class Members
    def member_container
      noko.css('.team-member')
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
