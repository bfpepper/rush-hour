
module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      binding.pry
      erb :"clients/new"
    end

  end
end
