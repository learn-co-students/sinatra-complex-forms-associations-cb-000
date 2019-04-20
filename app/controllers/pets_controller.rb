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
    
    if !params[:owner][:name].empty?
      @pet = Pet.new
      @pet.name = params[:pet][:name]
      @pet.owner = Owner.create(name: params[:owner][:name])
      @pet.save
    else
      @pet = Pet.create(params[:pet])
    end

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
      @pet.name = params[:pet_name]
      @pet.save
    else
      @pet.update(name: params[:pet_name], owner_id: params[:pet][:owner_id])
    end
    redirect to "pets/#{@pet.id}"
  end
end