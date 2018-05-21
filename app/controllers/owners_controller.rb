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
    @owner = Owner.create(name: params["owner"]["name"], pet_ids: params["owner"]["pet_ids"])
    @owner.pets << Pet.create(name: params["pet"]["name"]) if !params["pet"]["name"].empty?
    @owner.save
    redirect "/owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do
    binding.pry
    @owner = Owner.find(params[])
  end

  helpers do
    def belongs_to_owner?(pet)
      @owner.pets.exists?(pet.id) == true
    end
  end

end
