class DealerDirectRts
  def initialize
    @helper = RtsHelper.new
    @manager = RtsManager.new
  end

  def rooftop_scraper(html, url, indexer)
    orgs, streets, cities, states, zips, phones = [], [], [], [], [], []
    rts_phones = @manager.rts_phones_finder(html) # Scrape all the phone numbers.

    orgs << html.at_css('.dealer-name').text if html.at_css('.dealer-name')
    orgs << html.at_css('title').text if html.at_css('title')
    orgs << html.at_css('.adr .org').text if html.at_css('.adr .org')
    orgs << html.at_css('.org').text if html.at_css('.org')
    orgs << html.at_css('.dealer-title a alt').text if html.at_css('.dealer-title a alt')

    phones << html.at_css('span[@itemprop="telephone"]').text if html.at_css('span[@itemprop="telephone"]')
    phones << html.at_css('#CTN_primary').text if html.at_css('#CTN_primary')
    phones << html.at_css('.phones').text if html.at_css('.phones')
    phones << html.at_css('.dept_phn_num').text if html.at_css('.dept_phn_num')
    phones << html.at_css('.phone1 .value').text if html.at_css('.phone1 .value')
    phones << html.at_css('#header-phone').text if html.at_css('#header-phone')
    phones << html.at_css('.PhoneNumber').text if html.at_css('.PhoneNumber')
    phones << html.at_css('.department-phone-numbers').text if html.at_css('.department-phone-numbers')

    streets << html.at_css('span[@itemprop="streetAddress"]').text if html.at_css('span[@itemprop="streetAddress"]')
    streets << html.at_css('.adr .street-address').text if html.at_css('.adr .street-address')
    streets << html.at_css('.street-address').text if html.at_css('.street-address')

    cities << html.at_css('span[@itemprop="addressLocality"]').text if html.at_css('span[@itemprop="addressLocality"]')
    cities << html.at_css('.adr .locality').text if html.at_css('.adr .locality')
    cities << html.at_css('.locality').text if html.at_css('.locality')

    states << html.at_css('span[@itemprop="addressRegion"]').text if html.at_css('span[@itemprop="addressRegion"]')
    states << html.at_css('.adr .region').text if html.at_css('.adr .region')
    states << html.at_css('.region').text if html.at_css('.region')

    zips << html.at_css('span[@itemprop="postalCode"]').text if html.at_css('span[@itemprop="postalCode"]')
    zips << html.at_css('.adr .postal-code').text if html.at_css('.adr .postal-code')
    zips << html.at_css('.postal-code').text if html.at_css('.postal-code')

    addr1 = html.at_css('#address').text if html.at_css('#address')
    addr2 = html.at_css('.footer-address').text if html.at_css('.footer-address')
    result_1 = @helper.addr_processor(addr1)
    result_2 = @helper.addr_processor(addr2)

    streets.concat([ result_1[:street], result_2[:street] ]) # [string, string ...]
    cities.concat([ result_1[:city], result_2[:city] ]) # [string, string ...]
    states.concat(result_1[:states] + result_2[:states]) # arrary + array + ....
    zips.concat(result_1[:zips] + result_2[:zips]) # arrary + array + ....
    phones.concat(result_1[:phones] + result_2[:phones]) # arrary + array + ....

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
