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
    @owner = Owner.create(name: params[:owner][:name])

    if params[:pet][:name] != nil
      new_pet = Pet.create(name: params[:pet][:name])
      new_pet.owner = @owner
      new_pet.save
    end

    old_pets = params[:owner][:pet_ids]
    if old_pets != nil
      old_pets.each do |id|
        pet = Pet.find(id)
        pet.owner = @owner
        pet.save
      end
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
    old_pets = params[:owner][:pets_id]

    @owner.name = params[:owner][:pets_id]
    @owner.save

    if old_pets != nil
      old_pets.each do |id|
        @pet = Pet.find(id)
        @pet.owner = @owner
        @pet.save
      end
    end

    if params[:new_pet] != nil
      new_pet = Pet.create(name: params[:new_pet])
      new_pet.owner = @owner
      new_pet.save
    end

    redirect to "/owners/#{@owner.id}"
  end
end
