class Owner < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  has_many :restaurants, :dependent => :destroy

  # attr_accessible :title, :body

  #Validations
  validates :name,	:presence => true,
  					:format => {:with => /^[^0-9`!@#\$%\^&*+_=]+$/}

  validates :email, :presence => true,
            :email_format => {:message => 'is not looking good'},
  					:uniqueness => true 

	def has_ownership?(restaurant)
		self.restaurants.find_by_id(restaurant.id).present?
	end
end
