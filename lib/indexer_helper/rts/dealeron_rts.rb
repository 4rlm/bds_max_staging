class DealeronRts
  def initialize
    @helper  = RtsHelper.new
    @manager = RtsManager.new
  end

  def rooftop_scraper(html, url, indexer)
    rts_phones = @manager.rts_phones_finder(html) # Scrape all the phone numbers.

    acc_phones = html.css('.callNowClass').collect {|phone| phone.text if phone}
    raw_full_addr = html.at_css('.adr').text if html.at_css('.adr')
    full_addr_arr = raw_full_addr.split(",") if raw_full_addr

    if full_addr_arr
      street_city_arr = strict_city_divider(full_addr_arr[0..-2])
      zip_state_arr = full_addr_arr[-1].split(" ")

      street = street_city_arr[0]
      city = street_city_arr[-1]
      state = zip_state_arr[-2]
      zip = zip_state_arr[-1]
    end

    org = html.at_css('.dealerName').text if html.at_css('.dealerName')
    phone = acc_phones[0]

    ### MOVED FROM address_formatter B/C DESIGNED ONLY FOR DO TEMP.
    if (city && street == nil) && city.include?("\r")
      street_city_arr = city.split("\r")
      street = street_city_arr[0] unless street_city_arr[0] == nil
      city = street_city_arr[-1] unless street_city_arr[-1] == nil
    end

    @manager.address_formatter(org, street, city, state, zip, phone, rts_phones, url, indexer)
  end

  def strict_city_divider(arr)
    l = arr.length
    result = []

    if l == 1
      parts = arr
      if arr.first.include?("\n")
        parts = arr.first.split("\n")
      elsif arr.first.include?("\r")
        parts = arr.first.split("\r")
      end
      parts.delete_if {|x| x.blank?}
      parts = parts.uniq
      result = parts.map(&:strip)
    elsif l == 2
      result = arr
    end
    result
  end
end
