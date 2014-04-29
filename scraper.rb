require 'scraperwiki'
require 'mechanize'

agent = Mechanize.new

url = "https://morph.io/documentation/examples/australian_members_of_parliament"

# Read in a page
page = agent.get(url)

page.search('.search-filter-results li').each do |li|
  record = {
    name: li.at('.title').inner_text.strip,
    url: li.at('.title a')["href"],
    member_for: li.search('dl dd')[0].inner_text,
    party: li.search('dl dd')[1].inner_text
  }
  p record
end

#
# # Find somehing on the page using css selectors
# p page.at('div.content')
#
# # Write out to the sqlite database using scraperwiki library
# ScraperWiki.save_sqlite(["name"], {"name" => "susan", "occupation" => "software developer"})
#
# # An arbitrary query against the database
# ScraperWiki.select("* from data where 'name'='peter'")

# You don't have to do things with the Mechanize or ScraperWiki libraries. You can use whatever gems are installed
# on Morph for Ruby (https://github.com/openaustralia/morph-docker-ruby/blob/master/Gemfile) and all that matters
# is that your final data is written to an Sqlite database called data.sqlite in the current working directory which
# has at least a table called data.
