class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end

  def user_cards
    current_user.cards if current_user
  end

  def current_deck
    if current_user
      if current_user.decks
        current_user.decks.find_by(id: current_user.current_deck_id)
      end
    end
  end

  def current_cards
    current_deck.present? ? current_deck.cards : user_cards
  end

end
