require 'test_helper'

class CollectionTest < ActiveSupport::TestCase

  test 'Collection не может существовать без единого CollectionItem' do
    c = Collection.new
    c.valid?
    refute_empty c.errors[:collection_items]
  end

  test 'Collection может существовать хотя бы с одним CollectionItem' do
    c = Collection.new(collection_items: [CollectionItem.new])
    c.valid?
    assert_empty c.errors[:collection_items]
  end

  test 'Collection не может существовать без названия' do
    c = Collection.new
    c.valid?
    refute_empty c.errors[:title]
  end

  test 'При удалении Collection удаляются все связанные объекты' do
    c = collections(:one)

    c.destroy!

    assert_raise ActiveRecord::RecordNotFound do
      collection_items(:one)
    end
    assert_raise ActiveRecord::RecordNotFound do
      collection_items(:two)
    end
  end

end
