class Card < ActiveRecord::Base
  belongs_to :player

  scope(:in_play, -> do
    where(in_play: true)
  end)
  
end
