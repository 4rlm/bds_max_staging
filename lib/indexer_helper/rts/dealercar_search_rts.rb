class DealercarSearchRts
  def initialize
    @helper = RtsHelper.new
    @manager = RtsManager.new
  end
  
  def rooftop_scraper(html, url, indexer)
    orgs, streets, cities, states, zips, phones, addrs = [], [], [], [], [], [], []
    rts_phones = @manager.rts_phones_finder(html) # Scrape all the phone numbers.

    orgs << html.css('title').text if html.css('title')
    orgs << html.css('.sepBar').text if html.css('.sepBar')
    streets << html.at_css('.LabelAddress1').text if html.at_css('.LabelAddress1')
    phones << html.at_css('.LabelPhone1').text if html.at_css('.LabelPhone1')

    addr_n_ph1 = html.at_css('.AddressPhone_Main').text if html.at_css('.AddressPhone_Main')
    [addr_n_ph1].each do |x|
      divided = @helper.addr_ph_divider(x)
      addrs.concat(divided)
      phones.concat(divided)
    end

    city_state_zip = html.at_css('.LabelCityStateZip1').text if html.at_css('.LabelCityStateZip1')
    [city_state_zip].each do |x|
      divided = @helper.city_state_zip_divider(x)
      cities << divided[:city] if !divided[:city].blank?
      states << divided[:state] if !divided[:state].blank?
      zips << divided[:zip] if !divided[:zip].blank?
    end

    puts "\n\n>>>>>>>>>>>>> ORIGINAL >>>>>>>>>>>>>\norgs: #{orgs.inspect}\nstreets: #{streets.inspect}\naddr_n_ph1: #{addr_n_ph1.inspect}\n\n"

    addrs.each do |addr|
      result = @helper.addr_processor(addr)
      streets << result[:street]
      cities << result[:city]
      states.concat(result[:states])
      zips.concat(result[:zips])
      phones.concat(result[:phones])
    end

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
end
