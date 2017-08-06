require 'test_helper'

class IndexerTermsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @indexer_term = indexer_terms(:one)
  end

  test "should get index" do
    get indexer_terms_url
    assert_response :success
  end

  test "should get new" do
    get new_indexer_term_url
    assert_response :success
  end

  test "should create indexer_term" do
    assert_difference('IndexerTerm.count') do
      post indexer_terms_url, params: { indexer_term: { category: @indexer_term.category, criteria_count: @indexer_term.criteria_count, criteria_term: @indexer_term.criteria_term, response_count: @indexer_term.response_count, response_term: @indexer_term.response_term, sub_category: @indexer_term.sub_category } }
    end

    assert_redirected_to indexer_term_url(IndexerTerm.last)
  end

  test "should show indexer_term" do
    get indexer_term_url(@indexer_term)
    assert_response :success
  end

  test "should get edit" do
    get edit_indexer_term_url(@indexer_term)
    assert_response :success
  end

  test "should update indexer_term" do
    patch indexer_term_url(@indexer_term), params: { indexer_term: { category: @indexer_term.category, criteria_count: @indexer_term.criteria_count, criteria_term: @indexer_term.criteria_term, response_count: @indexer_term.response_count, response_term: @indexer_term.response_term, sub_category: @indexer_term.sub_category } }
    assert_redirected_to indexer_term_url(@indexer_term)
  end

  test "should destroy indexer_term" do
    assert_difference('IndexerTerm.count', -1) do
      delete indexer_term_url(@indexer_term)
    end

    assert_redirected_to indexer_terms_url
  end
end
