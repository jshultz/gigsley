class Profile < ActiveRecord::Base
  geocoded_by :full_address   # can also be an IP address
  after_validation :geocode #, if: ->(obj){ obj.full_address.present? and obj.full_address.changed? }

  acts_as_messageable
  acts_as_ordered_taggable # Alias for acts_as_taggable_on :tags
  acts_as_ordered_taggable_on :skills, :interests

  validates :name, presence: true, on: [:create,:update]
  validates :street, presence: true, on: [:create,:update]
  validates :city, presence: true, on: [:create,:update]
  validates :state, presence: true, on: [:create,:update]
  validates :home_phone, presence: true, on: [:create,:update]
  validates :terms, presence: true, on: :create

  validates :email,
            :presence => true,
            :format => { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ ,
                         :message => 'Invalid e-mail! Please provide a valid e-mail address'},
            :on => [:create, :update]

  include PgSearch

  belongs_to :user
  has_one :job
  has_one :bio
  has_many :gigs
  has_one :experience
  has_one :schedule
  has_many :galleries

  has_one :availability, as: :gig_sched

  pg_search_scope :profile_search, :against => [:first_name, :last_name]

  def mailboxer_name
    self.name
  end

  def mailboxer_email(object)
    self.email
  end

  #Returning the email address of the model if an email should be sent for this object (Message or Notification).
  #If no mail has to be sent, return nil.
  # def mailboxer_email(object)
  #   #Check if an email should be sent for that object
  #   #if true
  #   return "define_email@on_your.model"
  #   #if false
  #   #return nil
  # end
end
