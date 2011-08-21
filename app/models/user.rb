class User
  include Mongoid::Document
  field :uid, :type => String
  field :token, :type => String
  field :secret, :type => String
end
