require 'test_helper'

class ShowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @show = shows(:one)
  end

  test "should get index" do
    get shows_url
    assert_response :success
  end

  test "should get new" do
    get new_show_url
    assert_response :success
  end

  test "should create show" do
    assert_difference('Show.count') do
      post shows_url, params: { show: { list_id: @show.list_id, original_id: @show.original_id, season_id: @show.season_id, status: @show.status, title: @show.title, user_id: @show.user_id } }
    end

    assert_redirected_to show_url(Show.last)
  end

  test "should show show" do
    get show_url(@show)
    assert_response :success
  end

  test "should get edit" do
    get edit_show_url(@show)
    assert_response :success
  end

  test "should update show" do
    patch show_url(@show), params: { show: { list_id: @show.list_id, original_id: @show.original_id, season_id: @show.season_id, status: @show.status, title: @show.title, user_id: @show.user_id } }
    assert_redirected_to show_url(@show)
  end

  test "should destroy show" do
    assert_difference('Show.count', -1) do
      delete show_url(@show)
    end

    assert_redirected_to shows_url
  end
end
