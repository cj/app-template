# frozen_string_literal: true
require "test_helper"

# class RodauthControllerTest < ActionDispatch::IntegrationTest
#   describe "/create_account" do
#     let(:email) { "foo@bar.com" }
#
#     test "creating an account" do
#       create_account
#
#       assert_response :found
#       assert_redirected_to "/"
#     end
#
#     test "created account is encrypted" do
#       create_account
#
#       account = Account.find_by(email: email)
#
#       assert_not_nil account
#
#       assert_not_equal email, account.email
#     end
#   end
#
#   def create_account
#     post("/create-account", params: {
#       login: email,
#       password: "password",
#       'password-confirm': "password",
#     })
#   end
# end
