class QueriesController < ApplicationController

  def query
    search_term = strong_query_params[:term]
    search_language = strong_query_params[:language]
    # given a search term and a language, find all verses that include search_term
    # currently deos not search for pluralized/singularized alternative

    verses_with_match = find_verses_with_match(search_term, search_language)

    # group based on chapter
    verses_with_match = group_by_chapter(verses_with_match)

    render json: verses_with_match
    # ^^ may want to serialize this in some way to include Translation info
  end

  private
  def strong_query_params
    params.require(:query).permit(:term, :language)
  end

  def add_verse_to_map(map_obj, verse_obj)
    # group based on canonical_verse_id
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
            # check for both search term and pluralized/singularized alternative
              # pluralization/singularization of multiple-word-terms is more complex
                # for now match on all downcase, except ALLAH
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
