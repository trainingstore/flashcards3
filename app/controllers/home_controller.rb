class HomeController < ApplicationController
  skip_before_action :require_login, only: :index

  def home
    @card = current_cards.for_review.random_card.first
    if @card.nil?
      @card = user_cards.for_review.random_card.first
    end
  end

  def check_answer
    @card = user_cards.find(params[:checked_card_id])
    answer = params[:translation]
    if @card.check_translation(answer)
      flash[:success] = "#{@card.translated_text} = #{params[:translation].strip} = True"
      @card.arrange_review_date(1)
      @card.wrong_guess = 0
      @card.save
      redirect_to root_path
    elsif @card.typo?(answer)
      flash[:info] = "#{answer} was typed instead of #{@card.original_text}(#{@card.translated_text}. Please retype.)"
      render action: :home
    else
      flash[:danger] = "#{@card.translated_text} = #{params[:translation].strip} = False"
      @card.wrong_guess_counter
      check_wrong_guess_number(@card.wrong_guess)
    end
  end

  private

  def check_wrong_guess_number(wrong_guess)
    return render action: :home if wrong_guess <= 3
    @card.arrange_review_date(-6)
    flash[:danger] = 'More than 3 guesses'
    redirect_to root_path
  end

end
