class HomeController < ApplicationController
  skip_before_action :require_login, only: :index
  @@attempt = 0
  def home
    @card = current_cards.for_review.random_card.first
    if @card.nil?
      @card = user_cards.for_review.random_card.first
    end
  end

  def check_answer
    @card = user_cards.find(params[:checked_card_id])
    if @card.check_translation(params[:translation])
      flash[:success] = "#{@card.translated_text} = #{params[:translation].strip} = True"
      @card.arrange_review_date(true)
      @@attempt = 0
      redirect_to root_path
    else
      @@attempt += 1
      flash[:danger] = "#{@card.translated_text} = #{params[:translation].strip} = False attempt=#{@@attempt}"
      if @@attempt >= 3
        @card.arrange_review_date(false)
        @@attempt = 0
        redirect_to root_path
      else
        render action: :home
      end

    end

  end
end
