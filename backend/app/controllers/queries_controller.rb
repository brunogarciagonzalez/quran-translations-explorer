# TODO:
# - make it so that if search_term is multiple words, intial search to backend is for
# ...the search_term, but once that fetch resolves, alter search term (in front end) by
# ... emplying JS's Array.prototype.splice() and removing one word, iteratively as it goes
# ... though the search term and thus provides something similar to results when
# ... googling :"ruby docs gem splice" . see 'Missing: x' in a search result

# - make it so can search for search_term_x && search_term_y, meaning both terms are in same verse but there is no need for terms / words to be directly next to each other

class QueriesController < ApplicationController

  def query
    search_term = strong_query_params[:term]
    search_language = strong_query_params[:language]
    # given a search term and a language, find all verses that include search_term
    # TODO: currently does not search for pluralized/singularized alternative...
    # ... because search term can be multiple words

    verses_with_match = find_verses_with_match(search_term, search_language)

    # group based on chapter
    matched_verses_grouped_by_chapter = group_by_chapter(verses_with_match)

    render json: matched_verses_grouped_by_chapter
  end

  private
  def strong_query_params
    params.require(:query).permit(:term, :language)
  end

  def add_verse_to_map(map_obj, verse_obj)
    # group based on canonical_verse_id
    # include translation info
    shallow_clone = {
      translation: verse_obj.chapter.translation,
      canonical_verse_id: verse_obj.canonical_verse_id,
      chapter_id: verse_obj.chapter_id,
      number: verse_obj.number,
      content: verse_obj.content
    }

    if map_obj[verse_obj.canonical_verse_id]
      map_obj[verse_obj.canonical_verse_id] << shallow_clone
    else
      map_obj[verse_obj.canonical_verse_id] = [shallow_clone]
    end
    map_obj
  end

  def group_by_chapter(verse_obj)
    # already grouped by canonical_verse_id, now group based on chapter_id
    output_obj = {}

    verse_obj.each do |canonical_id, verses_array|
      example_target_verse = Verse.find_by(canonical_verse_id: canonical_id)
      chapter = example_target_verse.chapter
      # key will be chapter numbers (chapter.number) and value will be:
      # {title: chapter.title, verses: []}

      if output_obj[chapter.number]
          output_obj[chapter.number][:verses_data][example_target_verse.number] = {}
          output_obj[chapter.number][:verses_data][example_target_verse.number][:canonical_id] = canonical_id
          output_obj[chapter.number][:verses_data][example_target_verse.number][:verses] = verses_array
      else
        output_obj[chapter.number] = {}
        output_obj[chapter.number][:title] = chapter.title

        output_obj[chapter.number][:verses_data] = {}
        output_obj[chapter.number][:verses_data][example_target_verse.number] = {}
        output_obj[chapter.number][:verses_data][example_target_verse.number][:canonical_id] = canonical_id
        output_obj[chapter.number][:verses_data][example_target_verse.number][:verses] = verses_array
      end
    end
    output_obj
  end


  def find_verses_with_match(search_term, search_language)
    output_obj = {}

    Translation.all.each do |translation|
      if translation.language.downcase == search_language.downcase
        translation.chapters.each do |chapter|
          chapter.verses.each do |verse|
            # current version of this code is a simple downcase inclusion check
            # TODO: In the future, hopefully can:
              # check for both search term and pluralized/singularized alternative
              # keep Names of ALLAH unmanipulated, or upcased, as is what is proper in my opinion
            if verse.content.downcase.include?(search_term.downcase)
              output_obj = add_verse_to_map(output_obj, verse)
            end
          end
        end
      end
    end
    output_obj
  end
end
