require 'test_helper'

class InHostPosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @in_host_po = in_host_pos(:one)
  end

  test "should get index" do
    get in_host_pos_url
    assert_response :success
  end

  test "should get new" do
    get new_in_host_po_url
    assert_response :success
  end

  test "should create in_host_po" do
    assert_difference('InHostPo.count') do
      post in_host_pos_url, params: { in_host_po: { term: @in_host_po.term } }
    end

    assert_redirected_to in_host_po_url(InHostPo.last)
  end

  test "should show in_host_po" do
    get in_host_po_url(@in_host_po)
    assert_response :success
  end

  test "should get edit" do
    get edit_in_host_po_url(@in_host_po)
    assert_response :success
  end

  test "should update in_host_po" do
    patch in_host_po_url(@in_host_po), params: { in_host_po: { term: @in_host_po.term } }
    assert_redirected_to in_host_po_url(@in_host_po)
  end

  test "should destroy in_host_po" do
    assert_difference('InHostPo.count', -1) do
      delete in_host_po_url(@in_host_po)
    end

    assert_redirected_to in_host_pos_url
  end
end
