class Card < ApplicationRecord
  belongs_to :deck
  before_create { self.review_date = Date.today }
  validates :original_text, :translated_text, presence: true
  validates :box, numericality: { greater_than_or_equal_to: 0,
                                  less_than_or_equal_to: 5 }
  validates :wrong_guess, numericality: { greater_than_or_equal_to: 0,
                                          less_than_or_equal_to: 3 }
  validate :not_the_same
  validate :picture_size
  scope :for_review, -> { where("review_date <= ?", Date.today) }
  scope :latest, -> { order(review_date: :asc) }
  scope :random_card, -> { order("RANDOM()") }
  mount_uploader :picture, PictureUploader

  def typo?(answer)
    return false if DamerauLevenshtein.distance(original_text, answer) > 1
    differ = DamerauLevenshtein::Differ.new
    differ.run(original_text, answer)[0].include?('<subst>')
  end

  def review_dates
    [ Date.today, 12.hours.from_now, 3.days.from_now,
      1.week.from_now, 2.weeks.from_now, 1.month.from_now ]
  end

  def arrange_review_date(change)
    self.box += change
    self.box = 5 if self.box > 5
    self.box = 1 if self.box < 1
    self.wrong_guess = 0 if change.negative?
    update(box: box, review_date: review_dates[box])
  end

  def wrong_guess_counter
    update_attribute(:wrong_guess, wrong_guess + 1)
  end

  def not_the_same
    if self.original_text.casecmp(self.translated_text) == 0
      errors.add(:original_text, "and translated text shouldn't be equal.")
    end
  end

  def check_translation(translation)
    original_text.casecmp(translation.strip) == 0
  end

  def picture_size
    return unless picture.size > 6.megabytes
    errors.add(:picture, 'should be less than 6MB')
  end

end
