require 'typhoeus'
require 'typhoeus/adapters/faraday'

module Results
  def get_results_from_both_engines(query)
    hydra = Typhoeus::Hydra.hydra

    google = Typhoeus::Request.new(ENV['URI_GOOGLE'],
                                   params: {q: query})
    bing = Typhoeus::Request.new(ENV['API_URL_BING'],
                                 params: {q: query},
                                 headers: {'Ocp-Apim-Subscription-Key': ENV['API_KEY_BING']})

    hydra.queue google
    hydra.queue bing
    hydra.run

    {
        bing: parse_from_bing(bing.response.body),
        google: parse_from_google(google.response.body)
    }
  end

  def get_results_from_google(query)
    hydra = Typhoeus::Hydra.hydra
    google = Typhoeus::Request.new(ENV['URI_GOOGLE'], params: {q: query})

    hydra.queue google
    hydra.run

    {google: parse_from_google(google.response.body)}
  end

  def get_results_from_bing(query)
    hydra = Typhoeus::Hydra.hydra
    bing = Typhoeus::Request.new(ENV['API_URL_BING'],
                                 params: {q: query},
                                 headers: {'Ocp-Apim-Subscription-Key': ENV['API_KEY_BING']})

    hydra.queue bing
    hydra.run

    {bing: parse_from_bing(bing.response.body)}
  end
end