require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase

  test 'Не авторизованный пользователь не должен видть ссылку Личное' do
    get :index, path: ''
    assert_select "a", {count: 0, text: 'Мои файлы'}
  end

  test 'Авторизованный пользователь должен видеть ссылку Личное' do
    sign_in users(:one)
    get :index, path: ''
    assert_select "a", {count: 1, text: 'Мои файлы'}
  end

end
