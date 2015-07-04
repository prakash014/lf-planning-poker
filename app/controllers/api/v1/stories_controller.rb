class Api::V1::StoriesController < ApplicationController
  belongs_to :room

  def index
    room = Room.find(params[:id])
    stories = room.stories
    render json: stories.to_json
  end


  def assign_point
    story = Story.find(params[:id])
    story_point = params[:story_point]
    story.update(story_point: story_point)
    Pusher["room#{story.room.id}"].trigger('story_point_assigned', story.to_json)
    render json: {success: true, message: t(:story_point_updated)}, status: 200
  end

end
