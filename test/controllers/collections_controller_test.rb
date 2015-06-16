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

  test 'Мы должны найти данные из fixtures при просмотре Личного' do
    sign_in users(:one)
    get :index
    assert_match /Тестовая коллекция/, response.body
    assert_match /http:\/\/example.com/, response.body
    assert_match /thumb_rails.png/, response.body
  end

  test 'Мы можем удалить Collection' do
    sign_in users(:one)
    assert_difference( -> {Collection.count}, -1) do
      delete :destroy, id: collections(:one).id
    end
  end

  test 'Мы можем создать Collection с изображением и ссылкой' do
    sign_in users(:one)
    assert_difference(->{CollectionItem.count}, 2) do
      assert_difference([->{Collection.count}, ->{Link.count}, ->{Photo.count}]) do
        post :create,
           "collection" => {
             "title" => "Заголовок коллекции",
             "collection_items_attributes" => {
               "1433692320636" => {
                 "collectionable_type" => "Link", 
                 "collectionable_attributes" => {
                   "url" => "Адрес ссылки"
                 }, 
                 "_destroy" => "false"
               },
               "1433692324958" => {
                   "collectionable_type" => "Photo",
                   "collectionable_attributes" => {
                     "image" => fixture_file_upload('rails.png'),
                   "image_cache" => ""
                   },
                 "_destroy" => "false"
               }
             }
           }
      end
    end
  end

  test 'Мы можем удалить изображение из Collection, при этом останется ссылка' do
    sign_in users(:one)
    assert_difference( ->{Photo.count}, -1 ) do
      assert_no_difference( ->{Link.count} ) do
        patch :update,
         "collection" => {
          "title" => "Тестовая коллекция",
          "collection_items_attributes" => {
            "0" => {
              "collectionable_type" => "Link",
               "collectionable_attributes" => {
                 "url" => "http://example.com",
                 "id" => links(:one)
               },
               "_destroy" => "false",
               "id" => collection_items(:two)
            },
            "1" => {
              "collectionable_type" => "Photo",
              "collectionable_attributes" => {
                "image_cache" => "",
                "id" => photos(:one)
              },
              "_destroy" => "1",
              "id" => collection_items(:one)
            }
          }
        },
        "id" => "980190962"
      end
    end
  end

end
