require 'test_helper'

class CollectionTest < ActiveSupport::TestCase

  test 'Collection не может существовать без названия' do
    c = Collection.new
    c.valid?
    refute_empty c.errors[:title]
  end

end
