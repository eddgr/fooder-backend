require 'rest-client'

# Users
User.create(username: "edgar", password: "hello")
User.create(username: "viv", password: "hello")
User.create(username: "diana", password: "hello")
User.create(username: "mateo", password: "hello")

# Restaurants

# id, name, fsq_id, integer, contact, location, categories, price, menu, hours, tip_text, tip_photo

# Restaurant.find_or_create_by(name: "Sophie's")
# Restaurant.find_or_create_by(name: "Thunder Bun")

fetch = RestClient.get("https://api.foursquare.com/v2/venues/explore?section=food&ll=40.707000099999995,-74.0150941&client_id=#{ENV["FSQ_ID"]}&client_secret=#{ENV["FSQ_SECRET"]}&v=#{ENV["FSQ_VERSION"]}&radius=100000")

fetch_json = JSON.parse(fetch)["response"]["groups"][0]["items"]

fetch_json.each do |data|
  Restaurant.find_or_create_by(
    fsq_id: data["venue"]["id"],
    name: data["venue"]["name"],
    # contact: data["venue"]["contact"]["formattedPhone"],
    location: data["venue"]["location"]["formattedAddress"].join(", "),
    categories: data["venue"]["categories"][0]["pluralName"]
    # price: data["venue"]["price"]["message"],
    # menu: data["venue"]["menu"]["mobileUrl"],
    # hours: data["venue"]["hours"]["status"],
    # tip_text: data["venue"]["tips"][0]["text"],
    # tip_photo: data["venue"]["tips"][0]["photo"]["photourl"]
  )
end

# {
#   "reasons"=>{"count"=>0, "items"=>[{"summary"=>"This spot is popular", "type"=>"general", "reasonName"=>"globalInt
# eractionReason"}]},
#   "venue"=>{
#     "id"=>"589fa21e06f1a341b56346f3",
#     "name"=>"La Pasticceria di Eataly Downtown", "location"=>{
#       "lat"=>40.70988976935566, "lng"=>-74.01159770226452, "labeledLatLngs"=>[{"label"=>"display", "lat"=>40.709
# 88976935566, "lng"=>-74.01159770226452}],
#       "distance"=>436, "postalCode"=>"10007", "cc"=>"US", "neighborhood"=>"Fin
# ancial District", "city"=>"New York", "state"=>"NY", "country"=>"United States", "formattedAddress"=>["New York, N
# Y 10007", "United States"]}, "categories"=>[{"id"=>"4bf58dd8d48988d16a941735", "name"=>"Bakery", "pluralName"=>"Ba
# keries", "shortName"=>"Bakery", "icon"=>{"prefix"=>"https://ss3.4sqi.net/img/categories_v2/food/bakery_", "suffix"
# =>".png"}, "primary"=>true}], "photos"=>{"count"=>0, "groups"=>[]}}, "referralId"=>"e-3-589fa21e06f1a341b56346f3-2
# 7"
# }
