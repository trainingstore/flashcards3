module ApplicationHelper
  def deck_names
    current_user.decks.pluck(:name, :id)
  end

  def current_deck
    current_user.decks.find_by(id: current_user.current_deck_id) if current_user
  end

  def current_deck?(deck)
    return false if current_deck.nil?
    deck.id == current_deck.id
  end

  def current_deck_name
    current_deck&.name
  end

  def underline(locale)
    'text-decoration: underline;' if locale == I18n.locale
  end
end
