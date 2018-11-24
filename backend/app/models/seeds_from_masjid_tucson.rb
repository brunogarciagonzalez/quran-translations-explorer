# each html file to be parsed is acquired from:
# "https://www.masjidtucson.org/quran/frames/ch#{chapter_number}.html"

require "byebug"
require "rest-client"

class SeedsFromMasjidTucson

  def getters_iterator
    # initialize all 114 get requests to respective target urls
    (1..114).to_a.each do |num|
      byebug
      resp = RestClient.get(url_constructor(num))
      
    end
  end

  private

  def url_constructor(chapter_number)
    "https://www.masjidtucson.org/quran/frames/ch#{chapter_number}.html"
  end
end
