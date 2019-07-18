
user_table = ["newusername", "bathsalt@hotmail.com", "encryptopass"],
             ["couchmuffin", "grapes@mail.com", "cryptopass"],
             ["fodder", "7878bathsalt@hotmail.dot", "yptopass"],
             ["orangecabbage", "salt@coldmail.com", "enryptopas"],
             ["nilthought", "yellow@nail.com", "cryptop"]

user_table.each do |x|
  u = User.new
  u.username = x[0]
  u.email = x[1]
  u.password = x[2]
  u.save
end

airports_table = ["ECP", "PCB International"],
             ["F95", "Altha Priv."],
             ["AAF", "Apalachicola"],
             ["ORL", "Orlando"],
             ["0J6", "Headland"]

airports_table.each do |x|
  u = Airport.new
  u.airport_code = x[0]
  u.airport_name = x[1]
  u.save
end

reviews_table = ["Amazing experience!", 1],
             ["Excellent distance to food!", 3],
             ["Great to visit old Florida.", 2],
             ["Mickey Mouse!", 1],
             ["Country airport.", 2]

reviews_table.each do |x|
  u = Review.new
  u.content = x[0]
  u.user_id = x[1]
  u.save
end

User.first.airports << Airport.last
Airport.first.reviews << Review.last
User.last.airports << Airport.first
Airport.last.reviews << Review.first
