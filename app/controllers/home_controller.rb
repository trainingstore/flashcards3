class HomeController < ApplicationController
  skip_before_action :require_login, only: :index

  def home
    @card = user_cards.for_review.random_card.first if user_cards
  end

  def check_answer
    @card = user_cards.find(params[:checked_card_id])
    if @card.check_translation(params[:translation])
      flash[:success] = "#{@card.translated_text} = #{params[:translation].strip} = True"
      @card.arrange_review_date
      redirect_to root_path
    else
      flash[:danger] = "#{@card.translated_text} = #{params[:translation].strip} = False"
      render action: :home
    end

  end
end
