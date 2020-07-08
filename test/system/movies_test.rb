require "application_system_test_case"

class MoviesTest < ApplicationSystemTestCase
  setup do
    @movie = movies(:one)
  end

  test "visiting the index" do
    visit movies_url
    assert_selector "h1", text: "Movies"
  end

  test "creating a Movie" do
    visit movies_url
    click_on "New Movie"

    fill_in "List", with: @movie.list_id
    fill_in "Original", with: @movie.original_id
    fill_in "Status", with: @movie.status
    fill_in "Title", with: @movie.title
    fill_in "User", with: @movie.user_id
    click_on "Create Movie"

    assert_text "Movie was successfully created"
    click_on "Back"
  end

  test "updating a Movie" do
    visit movies_url
    click_on "Edit", match: :first

    fill_in "List", with: @movie.list_id
    fill_in "Original", with: @movie.original_id
    fill_in "Status", with: @movie.status
    fill_in "Title", with: @movie.title
    fill_in "User", with: @movie.user_id
    click_on "Update Movie"

    assert_text "Movie was successfully updated"
    click_on "Back"
  end

  test "destroying a Movie" do
    visit movies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Movie was successfully destroyed"
  end
end
