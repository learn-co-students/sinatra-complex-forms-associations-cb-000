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
  #  binding.pry
  @pet = Pet.create(name: params[:pet][:name])
  if !params[:owner_name].empty?
    owner = Owner.create(name: params[:owner_name])
    owner.save
    @pet.owner = owner
  else
  owner = Owner.find_by(params[:owner_ids])

   @pet.owner = owner
  end
  @pet.save
  redirect "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
      @params = params
      @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end


  get '/pets/:id' do

    @pet = Pet.find(params[:id])

    erb :'/pets/show'
  end

  post '/pets/:id' do
    @params = params
     @pet = Pet.find_by_id(params[:id])
     @pet.update(name: params[:pet_name])

     if !params[:owner_name].empty?

       owner = Owner.create(name: params[:owner_name])
        owner.save
       @pet.owner = owner

     else
       owner = Owner.find_by_id(params[:owner_id])

       @pet.owner = owner

     end
   @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
