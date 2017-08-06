require 'test_helper'

class StaffersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @staffer = staffers(:one)
  end

  test "should get index" do
    get staffers_url
    assert_response :success
  end

  test "should get new" do
    get new_staffer_url
    assert_response :success
  end

  test "should create staffer" do
    assert_difference('Staffer.count') do
      post staffers_url, params: { staffer: { cont_source: @staffer.cont_source, cont_status: @staffer.cont_status, sfdc_acct: @staffer.sfdc_acct, sfdc_cont_email: @staffer.sfdc_cont_email, sfdc_cont_fname: @staffer.sfdc_cont_fname, sfdc_cont_id: @staffer.sfdc_cont_id, sfdc_cont_inactive: @staffer.sfdc_cont_inactive, sfdc_cont_influence: @staffer.sfdc_cont_influence, sfdc_cont_job: @staffer.sfdc_cont_job, sfdc_cont_lname: @staffer.sfdc_cont_lname, sfdc_cont_phone: @staffer.sfdc_cont_phone, sfdc_group: @staffer.sfdc_group, sfdc_id: @staffer.sfdc_id, sfdc_sales_person: @staffer.sfdc_sales_person, sfdc_type: @staffer.sfdc_type, sfdc_ult_grp: @staffer.sfdc_ult_grp, site_acct: @staffer.site_acct, site_city: @staffer.site_city, site_cont_email: @staffer.site_cont_email, site_cont_fname: @staffer.site_cont_fname, site_cont_fullname: @staffer.site_cont_fullname, site_cont_influence: @staffer.site_cont_influence, site_cont_job: @staffer.site_cont_job, site_cont_job_raw: @staffer.site_cont_job_raw, site_cont_lname: @staffer.site_cont_lname, site_cont_phone: @staffer.site_cont_phone, site_ph: @staffer.site_ph, site_state: @staffer.site_state, site_street: @staffer.site_street, site_zip: @staffer.site_zip, staffer_date: @staffer.staffer_date, staffer_status: @staffer.staffer_status, template: @staffer.template } }
    end

    assert_redirected_to staffer_url(Staffer.last)
  end

  test "should show staffer" do
    get staffer_url(@staffer)
    assert_response :success
  end

  test "should get edit" do
    get edit_staffer_url(@staffer)
    assert_response :success
  end

  test "should update staffer" do
    patch staffer_url(@staffer), params: { staffer: { cont_source: @staffer.cont_source, cont_status: @staffer.cont_status, sfdc_acct: @staffer.sfdc_acct, sfdc_cont_email: @staffer.sfdc_cont_email, sfdc_cont_fname: @staffer.sfdc_cont_fname, sfdc_cont_id: @staffer.sfdc_cont_id, sfdc_cont_inactive: @staffer.sfdc_cont_inactive, sfdc_cont_influence: @staffer.sfdc_cont_influence, sfdc_cont_job: @staffer.sfdc_cont_job, sfdc_cont_lname: @staffer.sfdc_cont_lname, sfdc_cont_phone: @staffer.sfdc_cont_phone, sfdc_group: @staffer.sfdc_group, sfdc_id: @staffer.sfdc_id, sfdc_sales_person: @staffer.sfdc_sales_person, sfdc_type: @staffer.sfdc_type, sfdc_ult_grp: @staffer.sfdc_ult_grp, site_acct: @staffer.site_acct, site_city: @staffer.site_city, site_cont_email: @staffer.site_cont_email, site_cont_fname: @staffer.site_cont_fname, site_cont_fullname: @staffer.site_cont_fullname, site_cont_influence: @staffer.site_cont_influence, site_cont_job: @staffer.site_cont_job, site_cont_job_raw: @staffer.site_cont_job_raw, site_cont_lname: @staffer.site_cont_lname, site_cont_phone: @staffer.site_cont_phone, site_ph: @staffer.site_ph, site_state: @staffer.site_state, site_street: @staffer.site_street, site_zip: @staffer.site_zip, staffer_date: @staffer.staffer_date, staffer_status: @staffer.staffer_status, template: @staffer.template } }
    assert_redirected_to staffer_url(@staffer)
  end

  test "should destroy staffer" do
    assert_difference('Staffer.count', -1) do
      delete staffer_url(@staffer)
    end

    assert_redirected_to staffers_url
  end
end
