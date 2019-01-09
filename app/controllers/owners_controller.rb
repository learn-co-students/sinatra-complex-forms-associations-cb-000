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
    @owner = Owner.create(params[:owner])

    unless params[:pet][:name].empty?
      @owner.pets << Pet.create(name: params[:pet][:name])
    end

    redirect to "/owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    @owner.name = params[:owner][:name]
    @owner.save

    old_pets = params[:owner][:pets_id]
    if old_pets != nil
      old_pets.each do |id|
        pet = Pet.find(id)
        pet.owner = @owner
        pet.save
      end
    end

    unless params[:pet][:name].empty?
      @owner.pets << Pet.create(name: params[:pet][:name])
    end

    redirect to "/owners/#{@owner.id}"
  end
end
