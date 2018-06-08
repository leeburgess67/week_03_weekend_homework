require_relative( './models/customers.rb' )
require_relative( './models/films.rb' )
require_relative( './models/tickets.rb' )

require( 'pry' )

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()

customer1 = Customer.new({ 'name' => 'Bob Smith', 'funds' => 20 })
customer1.save()
customer2 = Customer.new({ 'name' => 'Anna Jones', 'funds' => 40 })
customer2.save()
customer3 = Customer.new({ 'name' => 'Jimbo McNeil', 'funds' => 100 })
customer3.save()
customer4 = Customer.new({ 'name' => 'Simon Keane', 'funds' => 0 })
customer4.save()



film1 = Film.new({ 'title' => 'Jaws 15', 'price' => '10.50'})
film1.save()
film2 = Film.new({ 'title' => 'Maze', 'price' => '6.5'})
film2.save()
film3 = Film.new({ 'title' => 'Eaten Alive 5', 'price' => '9'})
film3.save()



ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id
  })
ticket1.save()
ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film2.id
  })
ticket2.save()
ticket3 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film3.id
  })
ticket3.save()
ticket4 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film3.id
  })
ticket4.save()

binding.pry
nil
