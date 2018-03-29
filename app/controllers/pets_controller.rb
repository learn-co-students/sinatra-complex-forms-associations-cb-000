
require 'pry'
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
    # binding.pry
    @pet = Pet.create(params[:pet])


    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"]["name"])

      # something about the has-many association im sure
      @owner.pets << @pet
      @owner.save
    end;
    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    # @owner = Owner.find(params[:id])
    @pet = Pet.find(params[:id])

    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do

    redirect to "pets/#{@pet.id}"
  end
end
