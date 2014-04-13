require 'sinatra'
require 'unirest'
require 'twitter'

get '/:id' do
  content_type :json
  url = "http:\/\/i.imgur.com/#{ params[:id] }.jpg"

  # find a first & last name based on image

response = Unirest::post "https://lambda-face-recognition.p.mashape.com/album", 
  headers: { 
    "X-Mashape-Authorization" => "oiBL9npvfyhkRK5HFBjZNdCiYmWN6vtm"
  },
  parameters: { 
    "album" => "CELEBS"
  }

response = Unirest::post "https://lambda-face-recognition.p.mashape.com/album_train", 
  headers: {
    "X-Mashape-Authorization" => "oiBL9npvfyhkRK5HFBjZNdCiYmWN6vtm"
  },
  parameters: { 
    "album" => "CELEBS",
    "albumkey" => "b1ccb6caa8cefb7347d0cfb65146d5e3f84608f6ee55b1c90d37ed4ecca9b273",
    "entryid" => "TigerWoods",
    "urls" => "http:\/\/www.lambdal.com\/tiger.jpg"
  }

  response = Unirest::get "https://lambda-face-recognition.p.mashape.com/album_rebuild?album=CELEBS&albumkey=b1ccb6caa8cefb7347d0cfb65146d5e3f84608f6ee55b1c90d37ed4ecca9b273", 
  headers: { 
    "X-Mashape-Authorization" => "oiBL9npvfyhkRK5HFBjZNdCiYmWN6vtm"
  }

  response = Unirest::get "https://lambda-face-recognition.p.mashape.com/album?album=CELEBS&albumkey=b1ccb6caa8cefb7347d0cfb65146d5e3f84608f6ee55b1c90d37ed4ecca9b273", 
  headers: { 
    "X-Mashape-Authorization" => "oiBL9npvfyhkRK5HFBjZNdCiYmWN6vtm"
  }

  response = Unirest::post("https://lambda-face-recognition.p.mashape.com/recognize", 
  headers: { 
    "X-Mashape-Authorization" => "oiBL9npvfyhkRK5HFBjZNdCiYmWN6vtm"
  },
  parameters: { 
    "album" => "CELEBS",
    "albumkey" => "b1ccb6caa8cefb7347d0cfb65146d5e3f84608f6ee55b1c90d37ed4ecca9b273",
    "urls" => "http:\/\/www.lambdal.com\/tiger.jpg"
  })

  hash = { t_name: response.body()['photos'][0]["tags"][0]["uids"][0]["prediction"] }
  
  # find bio & location based on first & last name
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "nQTPjRPOzxpeXYyROfFBfMG72"
    config.consumer_secret     = "ZWcKX5Pic0Kz9eHMHWzizXPMdK4wg6EzDloPdUZNEUqbkq5phT"
    config.access_token        = "2157789854-3qRhY38s3HlmbAhO9SKHeFrVEReO0ATS32s2ZpI"
    config.access_token_secret = "0OvIgOxj16ct8rbnLxx2JQQINZNDTwA1WcA0skxzmnWtB"
  end

  client.methods
end