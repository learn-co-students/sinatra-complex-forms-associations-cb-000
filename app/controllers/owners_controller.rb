class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'
  end

  post '/owners' do
    owner = Owner.new params[:owner]

    unless params[:owner][:name].empty?
      owner.pets.build(params[:pet])
    end

    owner.save

    redirect "/owners/#{owner.id}"
  end

  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  post '/owners/:id' do
    owner = Owner.find_by(id: params[:id])
    owner.update(params[:owner])

    unless params[:pet][:name].empty?
      owner.pets.create(params[:pet])
    end

    redirect "/owners/#{owner.id}"
  end
end
