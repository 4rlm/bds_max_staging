class DealerComRts
  def initialize
    @helper = RtsHelper.new
    @manager = RtsManager.new
  end
  
  def rooftop_scraper(html, url, indexer)
    rts_phones = @manager.rts_phones_finder(html) # Scrape all the phone numbers.

    selector = "//meta[@name='author']/@content"
    org = html.xpath(selector).text if html.xpath(selector)
    street = html.at_css('.adr .street-address').text if html.at_css('.adr .street-address')
    city = html.at_css('.adr .locality').text if html.at_css('.adr .locality')
    state = html.at_css('.adr .region').text if html.at_css('.adr .region')
    zip = html.at_css('.adr .postal-code').text if html.at_css('.adr .postal-code')
    phone = html.at_css('.value').text if html.at_css('.value')

    @manager.address_formatter(org, street, city, state, zip, phone, rts_phones, url, indexer)
  end
end
