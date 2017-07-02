class BikeShareApp < Sinatra::Base

  get '/' do
    erb :dashboard
  end

  get '/stations' do
    @stations = Station.all
    erb :"stations/index"
  end

  get '/stations/new' do
    erb :"stations/new"
  end

  get '/station-dashboard' do
    @count = Station.total_station_count
    @average = Station.average_bikes_per_station
    @most_bikes = Station.most_bikes_avaiable
    @stations_with_most_bikes = Station.stations_with_most_bikes
    @fewest_bikes_avaiable = Station.fewest_bikes_avaiable
    @stations_with_fewest_bikes = Station.stations_with_fewest_bikes
    @most_recent_station = Station.most_recent_station
    @oldest_station = Station.oldest_station
    erb :"stations/station-dashboard"
  end

  get '/stations/:id' do
    @station = Station.find(params[:id])
    erb :"stations/show"
  end

  post '/stations/new' do
    @station = Station.new(params[:station])
    if @station.save
      redirect "/stations"
    else
      @params[:page] = :"/stations/new"
      erb :"/error"
    end
  end

  get '/stations/:id/edit' do
    @station = Station.find(params[:id])
    erb :"stations/edit"
  end

  get '/error' do
    erb :"error"
  end

  put '/stations/:id' do |id|
    if Station.update(id.to_i, params[:station]) == false
      @params[:page] = :"/stations/new"
      erb :"/error"
    else
      Station.update(id.to_i, params[:station])
      redirect "/stations/#{id}"
    end
  end

  delete '/stations/:id' do |id|
    Station.destroy(id.to_i)
    redirect '/stations'
  end

  def execute_statement(sql)
     results = ActiveRecord::Base.connection.execute(sql)
     if results.present?
         return results
     else
         return nil
     end
 end






end
