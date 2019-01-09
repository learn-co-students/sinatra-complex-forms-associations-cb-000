class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  # Creating both pet and owner
  post '/pets' do
    @pet = Pet.create(params[:pet])

    if params[:pet][:owner_id] != nil
      @pet.owner = Owner.find(params[:pet][:owner_id])
      @pet.save
    end

    unless params[:new_owner].empty?
      @pet.owner = Owner.create(name: params[:new_owner])
      @pet.save
    end

    redirect to "pets/#{@pet.id}"
  end

  # editing
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
    @pet.update(params[:pet])

    unless params[:owner][:name].empty?
      @pet.owner = Owner.create(params[:owner])
      @pet.save
    end

    redirect to "pets/#{@pet.id}"
  end
end
