require "sinatra"
require "pusher"
require "http"

pusher = Pusher::Client.new(
  app_id: ENV["PUSHER_APP_ID"],
  key: ENV["PUSHER_KEY"],
  secret: ENV["PUSHER_SECRET"],
  cluster: ENV["PUSHER_CLUSTER"],
  use_tls: true
)

def get_stock_prices(symbol)
  response = HTTP.get("https://us-stocks.herokuapp.com/quote?symbol=#{symbol.upcase}")
  JSON.parse(response.body)
end

get "/" do
  erb :index
end

post "/trigger" do
  company = ['nflx', 'googl', 'aapl', 'amzn'].sample

  stock = get_stock_prices(company)
  event = { 
    company: company.upcase, 
    price: stock['current_price'], 
    percent_change: stock['percent_change'], 
    currency: stock['currency'], 
    timestamp: Time.now 
  }
  
  pusher.trigger('cache-stock-prices', 'stock-updated', event)
end
