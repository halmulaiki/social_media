class User < ActiveRecord::Base
    validates :firstname, :lastname, :username, :password, presence: true
    validates :email, :username, uniqueness: true
    validates :password, length: {minimum: 5, max: 8}
end

class Dog < ActiveRecord::Base

end
