class DealerInspireRts
  def initialize
    @helper  = RtsHelper.new
    @manager = RtsManager.new
  end
  
  def rooftop_scraper(html, url, indexer)
    rts_phones = @manager.rts_phones_finder(html) # Scrape all the phone numbers.

    org = html.at_css('.organization-name').text if html.at_css('.organization-name')
    acc_phones = html.css('.tel').collect {|phone| phone.text if phone} if html.css('.tel')
    phone = acc_phones.join(', ')

    street = html.at_css('.street-address').text if html.at_css('.street-address')

    if street && street.include?(",")
      street = street.split(",")
      street = street[0]
      if street.include?("  ")
        street = street.split(" ")
        street = street.join(" ")
      end
      street = street.strip
    end

    city = html.at_css('.locality').text if html.at_css('.locality').text
    state = html.at_css('.region').text if html.at_css('.region').text
    zip = html.at_css('.postal-code').text if html.at_css('.postal-code').text

    @manager.address_formatter(org, street, city, state, zip, phone, rts_phones, url, indexer)
  end
end
