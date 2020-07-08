require "application_system_test_case"

class SeasonsTest < ApplicationSystemTestCase
  setup do
    @season = seasons(:one)
  end

  test "visiting the index" do
    visit seasons_url
    assert_selector "h1", text: "Seasons"
  end

  test "creating a Season" do
    visit seasons_url
    click_on "New Season"

    fill_in "Episode", with: @season.episode_id
    fill_in "Original", with: @season.original_id
    fill_in "Show", with: @season.show_id
    fill_in "Status", with: @season.status
    fill_in "Title", with: @season.title
    click_on "Create Season"

    assert_text "Season was successfully created"
    click_on "Back"
  end

  test "updating a Season" do
    visit seasons_url
    click_on "Edit", match: :first

    fill_in "Episode", with: @season.episode_id
    fill_in "Original", with: @season.original_id
    fill_in "Show", with: @season.show_id
    fill_in "Status", with: @season.status
    fill_in "Title", with: @season.title
    click_on "Update Season"

    assert_text "Season was successfully updated"
    click_on "Back"
  end

  test "destroying a Season" do
    visit seasons_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Season was successfully destroyed"
  end
end
