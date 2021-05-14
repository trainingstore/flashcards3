class Card < ApplicationRecord
  belongs_to :deck
  before_create do
    self.review_date = Date.today
    self.index = -1
  end
  validates :original_text, :translated_text, presence: true
  validate :not_the_same
  validate :picture_size
  scope :for_review, -> { where("review_date <= ?", Date.today) }
  scope :latest, -> { order(review_date: :asc) }
  scope :random_card, -> { order("RANDOM()") }
  mount_uploader :picture, PictureUploader

  def not_the_same
    if self.original_text.casecmp(self.translated_text) == 0
      errors.add(:original_text, "and translated text shouldn't be equal.")
    end
  end

  def arrange_review_date(check)
    periods = [ 1.day, 3.days, 1.week, 2.weeks, 1.month ]
    index = self.index #index starts from -1
    index = check ? index + 1 : 0
    update_attribute(:index, index)
    update_attribute(:review_date, Date.today + periods[index])
  end

  def check_translation(translation)
    original_text.casecmp(translation.strip) == 0
  end

  def picture_size
    return unless picture.size > 6.megabytes
    errors.add(:picture, 'should be less than 6MB')
  end

end
