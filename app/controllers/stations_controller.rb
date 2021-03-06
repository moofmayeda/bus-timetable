class StationsController < ApplicationController
  def index
    @stations = Station.all
    @all_lines_data = Line.big_map.to_json
  end

  def new
    @station = Station.new
  end

  def create
    @station = Station.new(station_params)
    if @station.save
      @station.line_ids = params[:station][:line_ids]
      flash[:notice] = "New station created!"
      redirect_to station_path(@station)
    else
      render 'new'
    end
  end

  def show
    @station = Station.find(params[:id])
  end

  def edit
    @station = Station.find(params[:id])
  end

  def update
    @station = Station.find(params[:id])
    if @station.update(station_params)
      @station.line_ids = params[:station][:line_ids]
      flash[:notice] = "Station updated successfully!"
      redirect_to station_path(@station)
    else
      render 'edit'
    end
  end

  def destroy
    @station = Station.find(params[:id])
    @station.stops.destroy_all
    @station.destroy
    redirect_to stations_path
  end

private
  def station_params
    params.require(:station).permit(:name)
  end
end
