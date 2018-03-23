require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:derek)
    @other_user = users(:archer)
  end

  test "layout links while not logged in" do
    get root_path
    assert_not is_logged_in?
    assert_template 'static_pages/home'

    assert_select "a[href=?]", root_path, count:2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path, count:2
    assert_select "a[href=?]", contact_path

    get help_path
    assert_template 'static_pages/help'
    get contact_path
    assert_template 'static_pages/contact'
    get about_path
    assert_template 'static_pages/about'
    get signup_path
    assert_template 'users/new'
  end
  
  test "layout links while logged in" do
    get root_path 
    assert_template 'static_pages/home'

    log_in_as(@user)
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!

    assert_select "a[href=?]", login_path, count:0
    assert_select "a[href=?]", root_path, count:2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path, count:2
    assert_select "a[href=?]", contact_path
    
    get help_path
    assert_template 'static_pages/help'
    get contact_path
    assert_template 'static_pages/contact'
    get about_path
    assert_template 'static_pages/about'
    get signup_path
    assert_template 'users/new'
    
  end

end
