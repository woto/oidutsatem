require 'test_helper'

class CommonsTest < ActionDispatch::IntegrationTest

  test 'После авторизации мы должны попасть в Личное' do
    post '/users/sign_in', user: {
      email: 'user@example.com',
      password: 'password'
    }
    assert_redirected_to  '/collections'
  end

  test 'После выхода у нас должна очиститься Devise сессия и нас должно перебросить на главную' do
    post '/users/sign_in', user: { email: 'user@example.com', password: 'password' }
    refute_empty session["warden.user.user.key"]

    delete '/users'

    refute session.key? "warden.user.user.key"
    assert_redirected_to root_path
  end

end
