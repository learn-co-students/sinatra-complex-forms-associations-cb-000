class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    # binding.pry
    @pet = Pet.create(name: params[:pet][:name])
    if !params["owner"]["name"].empty?
      @pet.owner << Owner.create(name: params["owner"]["name"])
    else
      @pet.owner = Owner.find(params[:pet][:owner_ids][0])
    end
    @owners = Owner.all
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do

    redirect to "pets/#{@pet.id}"
  end
end
