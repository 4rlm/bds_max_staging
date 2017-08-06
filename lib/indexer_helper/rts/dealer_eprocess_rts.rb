class DealerEprocessRts
  def initialize
    @helper = RtsHelper.new
    @manager = RtsManager.new
  end

  def rooftop_scraper(html, url, indexer)
    orgs, streets, cities, states, zips, phones, addrs = [], [], [], [], [], [], []
    rts_phones = @manager.rts_phones_finder(html) # Scrape all the phone numbers.

    orgs << html.at_css('.hd_site_title').text if html.at_css('.hd_site_title')
    orgs << html.at_css('#footer_site_info_rights').text if html.at_css('#footer_site_info_rights')
    orgs << html.at_css('head title').text if html.at_css('head title')
    orgs << html.at_css('#footer_seo_text_container h1').text if html.at_css('#footer_seo_text_container h1')
    orgs << html.at_css('.dealer-name').text if html.at_css('.dealer-name')

    phones << html.at_css('.phone-number').text if html.at_css('.phone-number')
    phones << html.at_css('.dept_number').text if html.at_css('.dept_number')
    phones << html.at_css('.hd_phone_no').text if html.at_css('.hd_phone_no')
    phones << html.at_css('.banner-phones').text if html.at_css('.banner-phones')
    phones << html.at_css('#contact-no').text if html.at_css('#contact-no')

    org_n_addr1 = html.css('#nav_group_1_col_1').text if html.css('#nav_group_1_col_1')
    org_n_addr2 = html.at_css('.footer_location_data').text if html.at_css('.footer_location_data')

    [org_n_addr1, org_n_addr2].each do |x|
      divided = @helper.org_addr_divider(x)
      orgs << divided[:org] if !divided[:org].blank?
      addrs << divided[:addr] if !divided[:addr].blank?
    end

    addrs << html.at_css('.address').text if html.at_css('.address')
    addrs << html.at_css('.header_address').text if html.at_css('.header_address')
    addrs << html.at_css('.banner-address').text if html.at_css('.banner-address')
    addrs << html.at_css('.subnav').text if html.at_css('.subnav')
    addrs << html.at_css('.address-container').text if html.at_css('.address-container')

    addrs.each do |addr|
      result = @helper.addr_processor(addr)
      streets << result[:street]
      cities << result[:city]
      states.concat(result[:states])
      zips.concat(result[:zips])
      phones.concat(result[:phones])
    end

    orgs = remove_copyright(orgs)
    orgs = @helper.org_processor(orgs)

    ### Call Methods to Process above Data
    org    = @helper.final_arr_qualifier(orgs, "org")
    street = @helper.final_arr_qualifier(streets, "street")
    city   = @helper.final_arr_qualifier(cities, "city")
    state  = @helper.final_arr_qualifier(states, "state")
    zip    = @helper.final_arr_qualifier(zips, "zip")
    phone  = @helper.final_arr_qualifier(phones, "phone")

    @manager.address_formatter(org, street, city, state, zip, phone, rts_phones, url, indexer)
  end

  def remove_copyright(orgs)
    orgs.map do |org|
      org.delete!("©") if org.include?("©")
      org.split("All Rights Reserved.").first if org.include?("All Rights Reserved.")
    end
  end
end
