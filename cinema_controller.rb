require('sinatra')
require('sinatra/contrib/all')
require( 'pry-byebug' )
require_relative( 'models/ticket' )
require_relative( 'models/customer' )
require_relative( 'models/film' )
require_relative( 'models/screening' )

get '/cinema_screenings' do
  @screenings = Screening.list_all()
  erb(:screenings)
end

get '/cinema_screenings/:id' do
  @screening = Screening.find(params[:id])
  erb(:show)
end
