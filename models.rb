class User < ActiveRecord::Base
    validates :firstname, :lastname, :username, :password, presence: true
    validates :email, :username, uniqueness: true
    validates :password, length: {minimum: 5, max: 8}
end
class Post < ActiveRecord::Base
    validates :title, length: {minimum: 1}
    validates :body, length: {minimum: 1}
end
