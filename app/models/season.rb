class Season < ApplicationRecord
  belongs_to :crop
<<<<<<< HEAD
  has_many :squares

=======
>>>>>>> origin/master
  validates :year, :presence => :true
  validates :crop_id, :presence => :true
  validates_format_of :year, :with => /[0-9]{,4}/
  validates_format_of :start_date, :with => /[1-9]\d\d\d-\d\d-\d\d/, :message => "Date must be in YYYY-MM-DD format"
  validates_format_of :transplant_date, :with => /([1-9]\d\d\d-\d\d-\d\d)|()/, :message => "Date must be in YYYY-MM-DD format"
  validates_format_of :harvest_date, :with => /([1-9]\d\d\d-\d\d-\d\d)|()/, :message => "Date must be in YYYY-MM-DD format"

  scope :this_year, -> { where( 'year = ?', Date.today.year.to_s ) }
end
