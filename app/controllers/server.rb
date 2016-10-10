

module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      if params[:identifier].nil? || params[:rootUrl].nil?
        status 403
        body "Missing Paramaters"
      elsif Client.find_by(identifier: params[:identifier], root_url: params[:rootUrl])
        status 403
        body "Identifier Already Exists"
      elsif Client.create(identifier: params[:identifier], root_url: params[:rootUrl])
        status 200
        result = {"identifier": params["identifier"]}.to_json
        body result
      end
    end

    post '/sources/:IDENTIFIER/data' do
      input = JSON.parse(params[:payload])

      p1 = Payload.create(
                      requested_at: input["requestedAt"],
                      url_id: Url.find_or_create_by(url: input["url"]).id,
                      responded_in: input["respondedIn"],
                      referrer_id: Referrer.find_or_create_by(url: input["referredBy"]).id,
                      request_type_id: RequestType.find_or_create_by(request: input["requestType"]).id,
                      event_name_id: EventName.find_or_create_by(event: input["eventName"]).id,
                      agent_id: Agent.find_or_create_by(os: UserAgent.parse(input["userAgent"].gsub('%3B',';')).platform, browser: UserAgent.parse(input["userAgent"]).browser).id,
                      screen_resolution_id: ScreenResolution.find_or_create_by(width: input["resolutionWidth"], height: input["resolutionHeight"]).id,
                      ip_id: Ip.find_or_create_by(address: input["ip"]).id,
                      client_id: Client.find_by(identifier: params["IDENTIFIER"]).id
      )
      binding.pry
    end
  end
end
