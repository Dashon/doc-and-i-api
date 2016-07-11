class RewardSerializer < ActiveModel::Serializer
  attributes :id, :name, :reward_type, :cost, :description, :image_url
  has_one :user
end
