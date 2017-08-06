class CobaltRts
  def initialize
    @helper  = RtsHelper.new
    @manager = RtsManager.new
  end

  def rooftop_scraper(html, url, indexer)
    orgs, streets, cities, states, zips, phones = [], [], [], [], [], []
    rts_phones = @manager.rts_phones_finder(html) # Scrape all the phone numbers.
    
    ### OUTLYER: Special format, so doesn't follow same process as others below.
    ### === FULL ADDRESS AND ORG VARIABLE ===
    addr_n_org1 = html.at_css('.dealer-info').text if html.at_css('.dealer-info')
    if !addr_n_org1.blank?
      addr_arr = @helper.addr_parser(addr_n_org1)
      city_state_zip = addr_arr[2]
      city_state_zip_arr = city_state_zip.split(",")
      state_zip = city_state_zip_arr[1]
      state_zip_arr = state_zip.split(" ") if state_zip

      orgs << addr_arr[0]
      streets << addr_arr[1]
      cities << city_state_zip_arr[0]
      states << state_zip_arr[0] if state_zip_arr
      zips << state_zip_arr[-1] if state_zip_arr
    end

    ### === PHONE VARIABLES ===
    phones.concat(html.css('.contactUsInfo').map(&:children).map(&:text)) if html.css('.contactUsInfo').any?
    phones << html.at_css('.dealerphones_masthead').text if html.at_css('.dealerphones_masthead')
    phones << html.at_css('.dealerTitle').text if html.at_css('.dealerTitle')
    phones << html.at_css('.cta .insight').text if html.at_css('.cta .insight')
    phones << html.at_css('.dealer-ctn').text if html.at_css('.dealer-ctn')

    ### === ORG VARIABLES ===
    orgs << html.at_css('.dealerNameInfo').text if html.at_css('.dealerNameInfo')
    orgs.concat(html.xpath("//img[@class='cblt-lazy']/@alt").map(&:value))
    orgs << html.at_css('.dealer .insight').text if html.at_css('.dealer .insight')
    orgs.concat(html.css('.card .title').map(&:children).map(&:text)) if html.css('.card .title').any?

    ### === ADDRESS VARIABLES ===
    addr2_sel = "//a[@href='HoursAndDirections']"
    addr2 = html.xpath(addr2_sel).text if html.xpath(addr2_sel)
    addr3 = html.at_css('.dealerAddressInfo').text if html.at_css('.dealerAddressInfo')
    addr_n_ph1 = html.at_css('.dealerDetailInfo').text if html.at_css('.dealerDetailInfo')
    addr4 = html.at_css('address').text if html.at_css('address')
    addr4 = html.at_css('address').text if html.at_css('address')
    addr5 = html.css('.card .content .text .copy span').map(&:children).map(&:text).join(', ') if html.css('.card .content .text .copy span')

    # puts "\n>>>>>>>>>>\n orgs: #{orgs}, addr_n_org1: #{addr_n_org1}, phones: #{phones}\n>>>>>>>>>>\n"

    result_1 = @helper.addr_processor(addr2)
    result_2 = @helper.addr_processor(addr3)
    result_3 = @helper.addr_processor(addr_n_ph1)
    result_4 = @helper.addr_processor(addr4)
    result_5 = @helper.addr_processor(addr5)

    streets.concat([ result_1[:street], result_2[:street], result_3[:street], result_4[:street], result_5[:street] ]) # [string, string ...]
    cities.concat([ result_1[:city], result_2[:city], result_3[:city], result_4[:city], result_5[:city] ]) # [string, string ...]
    states.concat(result_1[:states] + result_2[:states] + result_3[:states] + result_4[:states] + result_5[:states]) # arrary + array + ....
    zips.concat(result_1[:zips] + result_2[:zips] + result_3[:zips] + result_4[:zips] + result_5[:zips]) # arrary + array + ....
    phones.concat(result_1[:phones] + result_2[:phones] + result_3[:phones] + result_4[:phones] + result_5[:phones]) # arrary + array + ....

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
