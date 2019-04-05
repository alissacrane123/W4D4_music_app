class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true 
    validates :ensure_session_token, presence: true 
    after_initialize :ensure_session_token

    # attr_reader :password # NEED?

    def self.find_by_credentials(email, password)
        @user = User.find_by(email: email)
        if @user.nil?
            render json: 'No user matching those credentials'
        else 
            @user.is_password?(password) ? @user : nil 
        end
    end 

    def password=(password)
        # @password = password # NEED?
        self.password_digest = BCrypt::Password.create(password)
        self.save! # NEED?
    end 

    def is_password?(password)
        # is is Bcrypt.new or Bcrypt.create? self.pass_dig or self.pass?
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end 

    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end 

    def reset_session_token!
        self.session_token = self.class.generate_session_token
        self.save!
        self.session_token
    end 

    private 

    def ensure_session_token
        # use ||=, otherwise we'll get new ST every time user instance created
        # which includes finding it in the database
        self.session_token ||= self.class.generate_session_token 
    end 

end
