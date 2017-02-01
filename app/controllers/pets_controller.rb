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
    @pet = Pet.new(name: params[:pet][:name])
    owner = !params[:owner][:name].empty? ? Owner.create(name: params[:owner][:name]) :
            Owner.find(params[:pet][:owner_id])

    owner.pets << @pet
    owner.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end  

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet][:name])

    owner = !params[:owner][:name].empty? ? Owner.create(name: params[:owner][:name]) :
            Owner.find(params[:pet][:owner_id])   
    
    owner.pets << @pet
    owner.save
    redirect to "pets/#{@pet.id}"
  end
end