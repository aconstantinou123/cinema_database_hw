require( 'pry-byebug' )
require_relative( 'models/ticket' )
require_relative( 'models/customer' )
require_relative( 'models/film' )
require_relative( 'models/screening' )

Ticket.delete_all()
Screening.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new({'name' => 'Keith', 'funds' => 250.00})
customer1.save()
customer2 = Customer.new({'name' => 'Sandy', 'funds' => 200.00})
customer2.save()
customer3 = Customer.new({'name' => 'Craig', 'funds' => 50.00})
customer3.save()
customer4 = Customer.new({'name' => 'Zsolt', 'funds' => 50.00})
customer4.save()

# customer1.name = 'Bob'
# customer1.update()
#
# Customer.list_all()
#
film1 = Film.new({'title' => 'Memento', 'price' => 10.00 })
film1.save
film2 = Film.new({'title' => 'Inception', 'price' => 9.00 })
film2.save
film3 = Film.new({'title' => '22 Jump Street', 'price' => 11.00 })
film3.save
film4 = Film.new({'title' => 'Sausage Party', 'price' => 12.00})
film4.save

# pp Film.list_all()

# ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
# ticket1.save()
# ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
# ticket2.save()
# ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id})
# ticket3.save()
# ticket4 = Ticket.new({'customer_id' => customer4.id, 'film_id' => film4.id})
# ticket4.save()

Ticket.list_all()

# film4.title = 'Blade Runner 2049'
# film4.update()
screening1 = Screening.new({'film_id' => film1.id, 'start_time' => '2017-01-08 04:00:00', 'empty_seats' => 20})
screening1.save
screening2 = Screening.new({'film_id' => film2.id, 'start_time' => '2017-01-09 04:00:00', 'empty_seats' => 15})
screening2.save
screening3 = Screening.new({'film_id' => film3.id, 'start_time' => '2017-01-10 04:00:00', 'empty_seats' => 1})
screening3.save
screening4 = Screening.new({'film_id' => film4.id, 'start_time' => '2017-01-11 04:00:00', 'empty_seats' => 20})
screening4.save
screening5 = Screening.new({'film_id' => film4.id, 'start_time' => '2017-01-12 04:00:00', 'empty_seats' => 10})
screening5.save
screening6 = Screening.new({'film_id' => film2.id, 'start_time' => '2017-01-12 04:00:00', 'empty_seats' => 0})
screening6.save

Screening.list_all()
#
customer1.buy_ticket(screening1)
customer2.buy_ticket(screening1)
customer3.buy_ticket(screening1)
customer4.buy_ticket(screening1)

customer1.buy_ticket(screening1)

customer1.buy_ticket(screening4)
customer2.buy_ticket(screening4)
customer3.buy_ticket(screening5)
customer1.buy_ticket(screening6)

Screening.most_popular
binding.pry
nil
