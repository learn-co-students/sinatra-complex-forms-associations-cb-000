class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(name: params["pet"]["name"])
    @pet.owner = Owner.find(params["owner_id"]) if !params["owner_id"].empty?
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet = Pet.update(name: params["pet"]["name"])
    @pet.owner = Owner.find(params["owner_id"]) if !params["owner_id"].empty?
    @pet.owner = Owner.create(name: params["owner_name"]) if !params["owner_name"].empty?
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
