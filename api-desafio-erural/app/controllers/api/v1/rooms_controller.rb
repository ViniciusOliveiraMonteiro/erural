require 'securerandom'
class Api::V1::RoomsController < ApplicationController
  def index
    rooms = Room.all
    render json: rooms, status: 200
  end

  def show
    room = Room.find_by(uuid: params[:id])
    if room
      render json: room, status: 200
    else
      render json: {error: "Sala não encontrada"}
    end
  end

  def create
    room = Room.new(
      name: room_params[:name],
      video_url: room_params[:video_url],
      video_id: room_params[:video_id],
      uuid: SecureRandom.uuid
    )
    if room.save
      render json: room, status: 200
    else
      render json: {error: "Não foi possível criar a sala."}
    end
  end

  private
    def room_params
      params.require(:room).permit([
        :name,
        :video_url,
        :video_id,
        :uuid,
      ])
    end
end