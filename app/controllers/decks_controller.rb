class DecksController < ApplicationController
  before_action :set_deck, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token

  def index
    @decks = current_user.decks.order(name: :asc)
  end

  def show
    @cards = @deck.cards.latest
    @number = @cards.count
  end

  def new
    @deck = current_user.decks.build
  end

  def edit; end

  def create
    @deck = current_user.decks.build(deck_params)
    if @deck.save
      flash[:success] = 'Deck was successfully created.'
      redirect_to @deck
    else
      render :new
    end
  end

  def update
    if @deck.update(deck_params)
      flash[:success] = 'Deck was successfully updated.'
      redirect_to @deck
    else
      render :edit
    end
  end

  def destroy
    @deck.destroy
    flash[:success] = 'Deck was successfully destroyed.'
    redirect_to decks_path
  end

  def select_current_deck
    current_user.assign_current_deck(params[:current_deck_id])
    flash[:success] = 'Deck was successfully changed.'
    redirect_to decks_path
  end

  private

  def set_deck
    @deck = current_user.decks.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(:name, :id)
  end
end
