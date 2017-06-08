class PetsController < ApplicationController


  #new
  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  #create
  post '/pets' do
    @pet = Pet.create(params[:pet])
    unless params[:owner_name].empty?
      @pet.owner = Owner.create(name: params[:owner_name])
      @pet.save
    end
    redirect "pets/#{@pet.id}"
  end

  #edit
  get '/pets/:id/edit'do
    @pet = Pet.find(params[:id])
    erb :'pets/edit'
  end

  #show
  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  #update
  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect "pets/#{@pet.id}"
  end
  #index
  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end
end
