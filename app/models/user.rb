class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :invitable, :registerable, :validatable,
         :validate_on_invite => false
  devise :omniauthable, :omniauth_providers => [:facebook]

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates :fullname, :email, presence: true, on: :create

  def override_confirmable_email
    self.confirmed_at = DateTime.current
    self.save
  end

  private

end
