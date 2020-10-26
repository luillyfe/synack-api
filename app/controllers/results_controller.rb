class ResultsController < ApplicationController
  def index
    query = params[:query]
    engine = params[:engine] || 'BOTH'
    @results = {message: 'No query provided'}

    unless query.empty?
      @results = case engine
                 when 'GOOGLE'
                   get_results_from_google(query)
                 when 'BING'
                   get_results_from_bing(query)
                 when 'BOTH'
                   get_results_from_both_engines(query)
                 else
                   {message: 'engine not supported'}
                 end
    end

    json_response(@results)
  end
end
