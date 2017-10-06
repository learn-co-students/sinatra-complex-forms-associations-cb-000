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
    if !params[:owner_name].empty?
      owner = Owner.create(name: params[:owner_name])
      pet = Pet.create(name: params[:pet][:name], owner: owner)
    else
      pet = Pet.create(params[:pet])
    end

    redirect "pets/#{pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by(id: params[:id])
    @owners = Owner.all

    erb :'pets/edit'
  end

  post '/pets/:id' do
    pet = Pet.find_by(id: params[:id])

    if !params[:owner_name].empty?
      new_owner = Owner.create(name: params[:owner_name])
      pet.owner = new_owner
      pet.name = params[:pet][:name]
      pet.save
    else
      pet.update(params[:pet])
    end

    redirect to "pets/#{pet.id}"
  end
end
