module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end
  def parse_from_google(res)
    JSON.parse(res)["items"].map{ |item| {
        :link => item.as_json["link"],
        :title => item.as_json["title"],
        :snippet => item.as_json["snippet"],
    }}
  end
  def parse_from_bing(res)
    JSON.parse(res)["webPages"].as_json["value"].map{ |item| {
        :link => item.as_json["url"],
        :title => item.as_json["name"],
        :snipped => item.as_json["snippet"],
    }}
  end
end