require 'test_helper'

class CollectionsControllerTest < ActionController::TestCase

  test 'Не авторизованному пользователю при попытке зайти в Личное предлагают авторизоваться' do
    get :index
    assert_redirected_to new_user_session_path
  end

  test 'Авторизованный пользователь может просматривать Личное' do
    sign_in users(:one)
    get :index
    assert_response :success
  end

  test 'Мы можем удалить Collection' do
    sign_in users(:one)
    assert_difference( -> {Collection.count}, -1) do
      delete :destroy, id: collections(:one).id
    end
  end

end
