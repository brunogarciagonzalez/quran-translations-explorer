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

    @all_translated_chapters = []
    (1..114).to_a.map do |num|
      puts "chapter #{num}..."
      # TODO: the below array needs to conform to model array at bottom of file
      chapter_translation_verses_array = chapter_translation_parser(num)

      # TODO: the below array needs to conform to model array at bottom of file
      # chapter_footnotes_array = chapter_footnotes_parser(num)

      parsed_chapter_translation_ONLY_to_hash(chapter_translation_verses_array, num)
      # parsed_chapter_translation_and_fn_to_hash(chapter_translation_verses_array, chapter_footnotes_array)
    end

    @all_translated_chapters
  end

  def add_to_db
    # call after getters_iterator
    # make use of populated @all_translated_chapters


  end

  private

  def parsed_chapter_translation_ONLY_to_hash(chapter_translation_verses, chapter_num)
    ### from:
    # ["[1:1] In the name of GOD, Most Gracious, Most Merciful.*", "[1:2] Praise be to GOD, Lord of the universe.", "[1:3] Most Gracious, Most Merciful.", "[1:4] Master of the Day of Judgment.", "[1:5] You alone we worship; You alone we ask for help.", "[1:6] Guide us in the right path;", "[1:7] the path of those whom You blessed; not of those who have deserved wrath, nor of the strayers."]
    ### to:
    # {chapter_num: int,
    # translation_url: "",
    # footnotes_url: "",
    # verses:[
    #   {verse_num: int.
    #   verse_text: "",
    #   link_to_footnotes: true || false
    #   }
    # ]
    # }

    chapter_translation_obj = {
      chapter_num: chapter_num,
      translation_url: ch_url_constructor(chapter_num),
      footnotes_url: ch_fn_url_constructor(chapter_num),
      verses:[]
    }

    # counter = 0
    chapter_translation_verses.each do |verse_string|
      #need to remove messages that are not verses
      if verse_string.include?("[") && verse_string.include?(":")
        verse_obj = {
          verse_num: verse_string.split(":", 2)[1].split("]", 2)[0],
          verse_text: verse_string.split(" ",2)[1],
          link_to_footnotes: verse_string.include?("*")
        }
        chapter_translation_obj[:verses].push(verse_obj)
        # counter = counter + 1
      end

    end

    # {verse_num: int.
    # verse_text: "",
    # link_to_footnotes: true || false
    # }



    @all_translated_chapters.push(chapter_translation_obj)

  end

  def parsed_chapter_translation_and_fn_to_hash(chapter_translation_array, chapter_footnotes_array)
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

########## only translation:
# {chapter_num: int,
# translation_url: "",
# footnotes_url: "",
# verses:[
#   {verse_num: int.
#   verse_text: "",
#   link_to_footnotes: true || false
#   }
# ]
# }

########## both translation & footnotes
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
