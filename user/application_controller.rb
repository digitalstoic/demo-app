require 'sinatra'
require 'riak'
require 'tweetstream'
require 'json'
require_relative './models/database_interact'
require_relative './models/twitter_interact'
require_relative './models/configure_database'
require_relative './models/configure_twitter'
require_relative './models/hashtag_interact'

class ApplicationController < Sinatra::Base

  include TwitterHelper
  include DatabaseHelper
  include HashtagHelper

  database_connect   = Connect. new
  client_database    = database_connect.connect_to_database
  twitter_connect    = ConfigureTwitter. new
  twitter_client     = twitter_connect.connect_to_twitter

  get '/' do 
    @data_to_read  = what_data_to_read(client_database)
    @tweets = show_me_tweets(client_database, @data_to_read)
    erb :index
  end

  get '/history' do
    #hashtag = "#{params[:hashtag]}"
    hashtag = "alex"
    tweets_to_show = 9
    get_list_of_tweets_for_hashtag(tweets_to_show, @data_to_read, hashtag, client_database)
  end
end
