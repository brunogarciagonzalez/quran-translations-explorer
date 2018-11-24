# each html file set (translation & footnotes) to be parsed is acquired from:
# "https://www.masjidtucson.org/quran/frames/ch#{chapter_number}.html"
# "https://www.masjidtucson.org/quran/frames/ch#{chapter_number}fn.html"

require "byebug"
require "nokogiri"

class SeedsFromMasjidTucson #likely will need to change class name once data is localized

  def getters_iterator
    # would like to transition from get requests to localized json asap

    # initialize all 114 get requests to respective target urls
    # produce a hash of all of the data, so that seeding can work independently of internet
    (1..114).to_a.map do |num|

      # TODO: the below array needs to conform to model array at bottom of file
      chapter_translation_verses_array = chapter_translation_parser(num)

      # TODO: the below array needs to conform to model array at bottom of file
      chapter_footnotes_array = chapter_footnotes_parser(num)

      parsed_chapter_info_to_hash(chapter_translation_verses_array, chapter_footnotes_array)
    end

  end

  private

  def parsed_chapter_info_to_hash(chapter_translation_array, chapter_footnotes_array)
    # need access to chapter_num, should have access to verse_num already
    # => should get verse_num during execution of #chapter_translation_parser and #chapter_footnotes_parser
    # for footnotes appears will be trickier because beginning of strings is not consistent (e.g. [1:1])
    byebug
  end

  def chapter_translation_parser(chapter_number)
    # chapter translation related
    chapter_translation_document = Nokogiri::HTML.parse(open(ch_url_constructor(chapter_number)))
    chapter_verses_html_array = chapter_translation_document.css("p a").select do |html|
      !html.inner_text.include?("Footnote")
    end

    chapter_verses_html_array.map do |verse_html|
      # splice out \t (horizontal tab) if needed
      if !verse_html.inner_text.include?("\t")
        verse_html.inner_text
      else
        verse_html.inner_text.split("\t").join("")
      end
    end
  end

  def chapter_footnotes_parser(chapter_number)
    # chapter footnotes related
    chapter_footnotes_document = Nokogiri::HTML.parse(open(ch_fn_url_constructor(chapter_number)))
    chapter_footnotes_document.css("p, table").map do |footnote_html|
      if footnote_html.name == "p"
        footnote_html.inner_text.split(/[\r\n\t]/).join("")
      else
        # only footnotes for chapter 1 translation has table, so this can be very specific parsing
        "<table>" +  footnote_html.inner_html.split(/[\r\n\s]/).join("") + "</table>"
      end
    end
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


# {chapter_num: int,
# translation_url: "",
# footnotes_url: "",
# verses:[
#   {verse_num: int.
#   verse_text: "",
#   link_to_footnotes: true || false
#   }
# ],
# footnotes:[
#   {
#     associated_verses: [ints],
#     text: ""
#   }
# ]
#
# }
