class CardsController < ApplicationController
  before_action :set_card, only: %i[edit show update destroy]

  def index
    @cards = user_cards.latest
    @number = user_cards.for_review.count
  end

  def new
    @card = user_cards.build
  end

  def create
    @card = user_cards.build(card_params)

    if @card.save
      flash[:success] = 'Card created'
      redirect_to cards_path
    else
      render :new
    end
  end

  def edit; end

  def show; end

  def update
     if @card.update(card_params)
       flash[:success] = 'Card updated'
       redirect_to card_path(@card)
     else
       render :edit
     end
  end

  def destroy
    @card.destroy
    flash[:success] = 'Card deleted'
    redirect_to cards_path
  end

  private
    def card_params
      params.require(:card).permit(:original_text, :translated_text, :review_date, :picture, :remote_picture_url)
    end

    def set_card
      @card = user_cards.find(params[:id])
    end
end
