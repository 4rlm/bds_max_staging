require 'test_helper'

class IndexersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @indexer = indexers(:one)
  end

  test "should get index" do
    get indexers_url
    assert_response :success
  end

  test "should get new" do
    get new_indexer_url
    assert_response :success
  end

  test "should create indexer" do
    assert_difference('Indexer.count') do
      post indexers_url, params: { indexer: { []: @indexer.[], array: @indexer.array, clean_url: @indexer.clean_url, crm_id_arr: @indexer.crm_id_arr, default: @indexer.default, indexer_status: @indexer.indexer_status, location_text: @indexer.location_text, location_url: @indexer.location_url, raw_url: @indexer.raw_url, redirect_status: @indexer.redirect_status, staff_text: @indexer.staff_text, staff_url: @indexer.staff_url, template: @indexer.template, true,: @indexer.true, } }
    end

    assert_redirected_to indexer_url(Indexer.last)
  end

  test "should show indexer" do
    get indexer_url(@indexer)
    assert_response :success
  end

  test "should get edit" do
    get edit_indexer_url(@indexer)
    assert_response :success
  end

  test "should update indexer" do
    patch indexer_url(@indexer), params: { indexer: { []: @indexer.[], array: @indexer.array, clean_url: @indexer.clean_url, crm_id_arr: @indexer.crm_id_arr, default: @indexer.default, indexer_status: @indexer.indexer_status, location_text: @indexer.location_text, location_url: @indexer.location_url, raw_url: @indexer.raw_url, redirect_status: @indexer.redirect_status, staff_text: @indexer.staff_text, staff_url: @indexer.staff_url, template: @indexer.template, true,: @indexer.true, } }
    assert_redirected_to indexer_url(@indexer)
  end

  test "should destroy indexer" do
    assert_difference('Indexer.count', -1) do
      delete indexer_url(@indexer)
    end

    assert_redirected_to indexers_url
  end
end
