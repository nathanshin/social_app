require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	test "invalid signup information" do 
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, user: { name: '',
															 email: 'user@foo',
															 password: 'foo',
															 password_confirmation: 'bar'}
		end
		assert_template 'users/new'
	end

	test "valid signup information" do
		get signup_path
		assert_difference 'User.count', 1 do
			post_via_redirect users_path, user: { name: 'Nate Shin',
															 email: 'nate@nate.com',
															 password: 'foobar',
														   password_confirmation: 'foobar'}
		end
		assert_template 'users/show'
		assert_select 'div.alert', "Welcome to the Social App!"
	end
end
