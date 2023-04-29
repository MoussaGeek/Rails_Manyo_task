class Task < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    validates :deadline_on, presence: true
    validates :priority, presence: true
    validates :status, presence: true

    enum priority: { low: 0, medium: 1, high: 2 }, _suffix: true
    enum status: { todo: 0, doing: 1, done: 2 }, _suffix: true

    scope :search_by_title, ->(search_title = nil) { where('title LIKE :search_title', search_title: "%#{search_title.strip}%") if search_title.present? && !search_title.strip.empty? }
    scope :filter_by_status, ->(status) { where(status: status) }
end
