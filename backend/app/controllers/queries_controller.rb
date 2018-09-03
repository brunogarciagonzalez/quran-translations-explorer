class QueriesController < ApplicationController

  def query
    search_term = strong_query_params[:term]
    byebug
    # given a search term and a language, find all verses that include either search term or pluralized/singularized alternative
  end

  private
  def strong_query_params
    params.require(:query).permit(:term, :language)
  end
end
