class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  RANSACKABLE_ATTRIBUTES = [].freeze
  RANSACKABLE_ASSOCIATIONS = [].freeze

  def self.ransackable_attributes(_auth_object = nil)
    self::RANSACKABLE_ATTRIBUTES
  end

  def self.ransackable_associations(_auth_object = nil)
    self::RANSACKABLE_ASSOCIATIONS
  end

  def self.ransack_query(sort:, query:)
    q = ransack(query)

    # ransack queries
    q = q.result.search(query) if query.present? && defined?(search)
    q = q.result.ransack(sort) if sort.present? && defined?(ransack)

    # default sort by created_at: :desc
    q.sorts = 'created_at desc' if q.sorts.empty?

    q
  end
end
