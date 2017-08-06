require 'test_helper'

class CoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @core = cores(:one)
  end

  test "should get index" do
    get cores_url
    assert_response :success
  end

  test "should get new" do
    get new_core_url
    assert_response :success
  end

  test "should create core" do
    assert_difference('Core.count') do
      post cores_url, params: { core: { bds_status: @core.bds_status, sfdc_acct: @core.sfdc_acct, sfdc_city: @core.sfdc_city, sfdc_group: @core.sfdc_group, sfdc_grp_rt: @core.sfdc_grp_rt, sfdc_id: @core.sfdc_id, sfdc_ph: @core.sfdc_ph, sfdc_sales_person: @core.sfdc_sales_person, sfdc_state: @core.sfdc_state, sfdc_street: @core.sfdc_street, sfdc_tier: @core.sfdc_tier, sfdc_type: @core.sfdc_type, sfdc_ult_grp: @core.sfdc_ult_grp, sfdc_ult_rt: @core.sfdc_ult_rt, sfdc_url: @core.sfdc_url, sfdc_zip: @core.sfdc_zip } }
    end

    assert_redirected_to core_url(Core.last)
  end

  test "should show core" do
    get core_url(@core)
    assert_response :success
  end

  test "should get edit" do
    get edit_core_url(@core)
    assert_response :success
  end

  test "should update core" do
    patch core_url(@core), params: { core: { bds_status: @core.bds_status, sfdc_acct: @core.sfdc_acct, sfdc_city: @core.sfdc_city, sfdc_group: @core.sfdc_group, sfdc_grp_rt: @core.sfdc_grp_rt, sfdc_id: @core.sfdc_id, sfdc_ph: @core.sfdc_ph, sfdc_sales_person: @core.sfdc_sales_person, sfdc_state: @core.sfdc_state, sfdc_street: @core.sfdc_street, sfdc_tier: @core.sfdc_tier, sfdc_type: @core.sfdc_type, sfdc_ult_grp: @core.sfdc_ult_grp, sfdc_ult_rt: @core.sfdc_ult_rt, sfdc_url: @core.sfdc_url, sfdc_zip: @core.sfdc_zip } }
    assert_redirected_to core_url(@core)
  end

  test "should destroy core" do
    assert_difference('Core.count', -1) do
      delete core_url(@core)
    end

    assert_redirected_to cores_url
  end
end
