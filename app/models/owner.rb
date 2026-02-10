class Owner < User
has_many :restaurants, foreign_key: "owner_id", dependent: :destroy
end
