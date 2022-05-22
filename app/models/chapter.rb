# == Schema Information
#
# Table name: chapters
#
#  id             :bigint           not null, primary key
#  download_state :integer
#  name           :string
#  number         :integer
#  url            :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  manga_id       :bigint
#
class Chapter < ApplicationRecord

  belongs_to :manga

  enum download_state: {
    pending: 0,
    in_progress: 1,
    error: 2,
    success: 3
  }

  scope :new_to_old_chapter, -> { order(number: :desc)}

end
