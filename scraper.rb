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
  ScraperWiki.save_sqlite(["name"], record)
end
