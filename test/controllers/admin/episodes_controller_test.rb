# frozen_string_literal: true

require "test_helper"

class Admin::EpisodesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_episodes_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_episodes_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_episodes_edit_url
    assert_response :success
  end
end
