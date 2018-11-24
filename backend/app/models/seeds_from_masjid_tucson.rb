# each html file to be parsed is acquired from:
# "https://www.masjidtucson.org/quran/frames/ch#{chapter_number}.html"

require "byebug"
require "nokogiri"

class SeedsFromMasjidTucson

  def getters_iterator
    # would like to transition from get requests to localized json asap

    # initialize all 114 get requests to respective target urls
    # produce a hash of all of the data, so that seeding can work independently of internet
    (1..114).to_a.map do |num|


      # translation_document = Nokogiri::HTML.parse(open(ch_url_constructor(num)))
      # footnotes_document = Nokogiri::HTML.parse(open(ch__fn_url_constructor(num)))

      # nokogiri_documents_to_hash(translation_document, footnotes_document)



    end

  end

  private

  def nokogiri_documents_to_hash(ng_obj)
    # document.inner_html or document.inner_text appears to work

  end

  def ch_url_constructor(chapter_number)
    # url for chapter translation
    "https://www.masjidtucson.org/quran/frames/ch#{chapter_number}.html"
  end

  def ch_fn_url_constructor(chapter_number)
    # url for chapter footnotes
    # all chapter tranlsations have footnotes
    "https://www.masjidtucson.org/quran/frames/ch#{chapter_number}fn.html"
  end
end
