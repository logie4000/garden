class Season < ApplicationRecord
  belongs_to :crop
  has_and_belongs_to_many :squares

  validates :year, :presence => :true
  validates :crop_id, :presence => :true
  validates_format_of :year, :with => /[0-9]{,4}/
  validates_format_of :start_date, :with => /[1-9]\d\d\d-\d\d-\d\d/, :message => "Date must be in YYYY-MM-DD format"
  validates_format_of :transplant_date, :with => /([1-9]\d\d\d-\d\d-\d\d)|()/, :message => "Date must be in YYYY-MM-DD format"
  validates_format_of :harvest_date, :with => /([1-9]\d\d\d-\d\d-\d\d)|()/, :message => "Date must be in YYYY-MM-DD format"

  scope :this_year, -> { where( 'year = ?', Date.today.year.to_s ) }

  def direct_seeded?
    return !self.transplant?
  end

  def transplant?
    return self.crop.transplant?
  end
end
