require 'test_helper'

class WhosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @who = whos(:one)
  end

  test "should get index" do
    get whos_url
    assert_response :success
  end

  test "should get new" do
    get new_who_url
    assert_response :success
  end

  test "should create who" do
    assert_difference('Who.count') do
      post whos_url, params: { who: { admin_address: @who.admin_address, admin_city: @who.admin_city, admin_country: @who.admin_country, admin_country_code: @who.admin_country_code, admin_created_on: @who.admin_created_on, admin_email: @who.admin_email, admin_fax: @who.admin_fax, admin_id: @who.admin_id, admin_name: @who.admin_name, admin_organization: @who.admin_organization, admin_phone: @who.admin_phone, admin_state: @who.admin_state, admin_type: @who.admin_type, admin_updated_on: @who.admin_updated_on, admin_url: @who.admin_url, admin_zip: @who.admin_zip, domain: @who.domain, domain_id: @who.domain_id, ip: @who.ip, registrant_address: @who.registrant_address, registrant_city: @who.registrant_city, registrant_country: @who.registrant_country, registrant_country_code: @who.registrant_country_code, registrant_created_on: @who.registrant_created_on, registrant_email: @who.registrant_email, registrant_fax: @who.registrant_fax, registrant_id: @who.registrant_id, registrant_name: @who.registrant_name, registrant_organization: @who.registrant_organization, registrant_phone: @who.registrant_phone, registrant_state: @who.registrant_state, registrant_type: @who.registrant_type, registrant_updated_on: @who.registrant_updated_on, registrant_url: @who.registrant_url, registrant_zip: @who.registrant_zip, registrar_id: @who.registrar_id, registrar_url: @who.registrar_url, server1: @who.server1, server2: @who.server2, tech_address: @who.tech_address, tech_city: @who.tech_city, tech_country: @who.tech_country, tech_country_code: @who.tech_country_code, tech_created_on: @who.tech_created_on, tech_email: @who.tech_email, tech_fax: @who.tech_fax, tech_id: @who.tech_id, tech_name: @who.tech_name, tech_organization: @who.tech_organization, tech_phone: @who.tech_phone, tech_state: @who.tech_state, tech_type: @who.tech_type, tech_updated_on: @who.tech_updated_on, tech_url: @who.tech_url, tech_zip: @who.tech_zip } }
    end

    assert_redirected_to who_url(Who.last)
  end

  test "should show who" do
    get who_url(@who)
    assert_response :success
  end

  test "should get edit" do
    get edit_who_url(@who)
    assert_response :success
  end

  test "should update who" do
    patch who_url(@who), params: { who: { admin_address: @who.admin_address, admin_city: @who.admin_city, admin_country: @who.admin_country, admin_country_code: @who.admin_country_code, admin_created_on: @who.admin_created_on, admin_email: @who.admin_email, admin_fax: @who.admin_fax, admin_id: @who.admin_id, admin_name: @who.admin_name, admin_organization: @who.admin_organization, admin_phone: @who.admin_phone, admin_state: @who.admin_state, admin_type: @who.admin_type, admin_updated_on: @who.admin_updated_on, admin_url: @who.admin_url, admin_zip: @who.admin_zip, domain: @who.domain, domain_id: @who.domain_id, ip: @who.ip, registrant_address: @who.registrant_address, registrant_city: @who.registrant_city, registrant_country: @who.registrant_country, registrant_country_code: @who.registrant_country_code, registrant_created_on: @who.registrant_created_on, registrant_email: @who.registrant_email, registrant_fax: @who.registrant_fax, registrant_id: @who.registrant_id, registrant_name: @who.registrant_name, registrant_organization: @who.registrant_organization, registrant_phone: @who.registrant_phone, registrant_state: @who.registrant_state, registrant_type: @who.registrant_type, registrant_updated_on: @who.registrant_updated_on, registrant_url: @who.registrant_url, registrant_zip: @who.registrant_zip, registrar_id: @who.registrar_id, registrar_url: @who.registrar_url, server1: @who.server1, server2: @who.server2, tech_address: @who.tech_address, tech_city: @who.tech_city, tech_country: @who.tech_country, tech_country_code: @who.tech_country_code, tech_created_on: @who.tech_created_on, tech_email: @who.tech_email, tech_fax: @who.tech_fax, tech_id: @who.tech_id, tech_name: @who.tech_name, tech_organization: @who.tech_organization, tech_phone: @who.tech_phone, tech_state: @who.tech_state, tech_type: @who.tech_type, tech_updated_on: @who.tech_updated_on, tech_url: @who.tech_url, tech_zip: @who.tech_zip } }
    assert_redirected_to who_url(@who)
  end

  test "should destroy who" do
    assert_difference('Who.count', -1) do
      delete who_url(@who)
    end

    assert_redirected_to whos_url
  end
end
