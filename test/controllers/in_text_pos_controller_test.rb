require 'test_helper'

class InTextPosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @in_text_po = in_text_pos(:one)
  end

  test "should get index" do
    get in_text_pos_url
    assert_response :success
  end

  test "should get new" do
    get new_in_text_po_url
    assert_response :success
  end

  test "should create in_text_po" do
    assert_difference('InTextPo.count') do
      post in_text_pos_url, params: { in_text_po: { term: @in_text_po.term } }
    end

    assert_redirected_to in_text_po_url(InTextPo.last)
  end

  test "should show in_text_po" do
    get in_text_po_url(@in_text_po)
    assert_response :success
  end

  test "should get edit" do
    get edit_in_text_po_url(@in_text_po)
    assert_response :success
  end

  test "should update in_text_po" do
    patch in_text_po_url(@in_text_po), params: { in_text_po: { term: @in_text_po.term } }
    assert_redirected_to in_text_po_url(@in_text_po)
  end

  test "should destroy in_text_po" do
    assert_difference('InTextPo.count', -1) do
      delete in_text_po_url(@in_text_po)
    end

    assert_redirected_to in_text_pos_url
  end
end
