class DealerfireRts
  def initialize
    @helper  = RtsHelper.new
    @manager = RtsManager.new
  end

  def rooftop_scraper(html, url, indexer)
    # v7_street = html.at_css('.full-address .address-1').text if html.at_css('.full-address .address-1')
    # v7_city_st_zp = html.at_css('.full-address .address-2').text if html.at_css('.full-address .address-2')
    rts_phones = @manager.rts_phones_finder(html) # Scrape all the phone numbers.
    
    phone = html.at_css('.contactWrap .hidden-text').text if html.at_css('.contactWrap .hidden-text')
    org = find_organization(html)
    addr_hash = find_address(html)

    @manager.address_formatter(org, addr_hash[:street], addr_hash[:city], addr_hash[:state], addr_hash[:zip], phone, rts_phones, url, indexer)
  end

  def find_organization(html)
    ### ORG: Copyright includes Org (Account Name).  Ranked based on reliability.
    if html.at_css('.location-name')
      org = html.at_css('.location-name').text
    elsif html.at_css('.footer-name')
      org = html.at_css('.footer-name').text
    elsif html.at_css('.ws-info-dealer')
      org = html.at_css('.ws-info-dealer').text
    elsif html.at_css('.layout-footer .links')
      org = copyright_extractor(html.at_css('.layout-footer .links').text)
    elsif html.at_css('.bottom-footer .links')
      org = copyright_extractor(html.at_css('.bottom-footer .links').text)
    elsif html.at_css('.dealer-name')
      org = html.at_css('.dealer-name').text
    end

    org = store_info_helper(org)
  end

  def find_address(html)
    ### FULL ADDRESS: RANKED BY MOST RELIABLE. ###
    street1 = html.at_css('.location-address').text if html.at_css('.location-address')
    city_state_zip1 = html.at_css('.location-state').text if html.at_css('.location-state')
    street2 = html.at_css('.footer-address').text if html.at_css('.footer-address')
    city_state_zip2 = html.at_css('.footer-state').text if html.at_css('.footer-state')

    if street1 && city_state_zip1
      add = "#{street1}, #{city_state_zip1}"
    elsif !html.css('.dealer-address').blank?
      add = html.css('.dealer-address').text
    elsif street2 && city_state_zip2
      add = "#{street2}, #{city_state_zip2}"
    elsif html.at_css('.header-address')
      add = html.at_css('.header-address').text
    elsif html.at_css('.layout-header .address')
      add = html.at_css('.layout-header .address').text
    elsif html.at_css('.layout-footer .ws-contact-text')
      add = html.at_css('.layout-footer .ws-contact-text').text
    elsif html.at_css('.foot-location')
      add = html.at_css('.foot-location').text
    elsif !html.css('.full-address').blank?
      add = html.css('.full-address').text
    elsif !html.css('.top-footer p').blank?
      add = html.css('.top-footer p').text
    elsif html.at_css('.ws-info-address')
      add = html.at_css('.ws-info-address').text
    elsif !html.css('.contact .footer-address').blank?
      add = html.css('.contact .footer-address').text
    end

    addr_arr = addr_get(add) if add
    addr_hash = {}
    if addr_arr
      addr_hash[:street] = addr_arr[0]
      addr_hash[:city] = addr_arr[1]
      addr_hash[:state] = addr_arr[2]
      addr_hash[:zip] = addr_arr[3]
    end
    addr_hash
  end

  def addr_get(info)
    ### FOR DealerFire RTS: Extracts full addr from "store info" section.
    info = nil if info.include?("\t\tClick Here for Locations\n\t")

    if info
      if info.include?("Map/Hours")
        info_arr = info.split(",")
        if info_arr[1].include?("\n")
          info_arr = info_arr[1].split("\n")
          street = info_arr[1]
          state_zip = info_arr[0]
        end
      elsif info.include?("Store Info\n")
        info_arr = info.split("\n")
        phone = info_arr[4]
        street = info_arr[2]
        city_state_zip = info_arr[3]
      elsif info.include?("Get Directions")
        info_arr = info.split("|")
        street = info_arr[0]
        city_state_zip = info_arr[1]
      elsif info.include?(",")
        com_cnt = info.count(",")
        info_arr = info.split(",")

        if com_cnt == 1
          street = info_arr[0]
          state_zip = info_arr[1]
        elsif com_cnt == 2
          street = info_arr[0]
          city = info_arr[1]
          state_zip = info_arr[2]
        end
      end

      if city_state_zip
        city_state_zip_arr = city_state_zip.split(",")
        city = city_state_zip_arr[0]
        state_zip = city_state_zip_arr[1]
      end

      if state_zip
        state_zip.strip!
        state_zip_arr = state_zip.split(" ")
        state = state_zip_arr[0]
        zip = state_zip_arr[1]
      end

      ### NEED HELP.  NOT REACTING, BUT WORKS ON REPL.
      ### http://www.avondalenissan.com
      ### http://www.germainnissan.com
      ### STREET: "4300 Morse Rd  \nColumbus, OH, 43230"

      # if street && street.include?("\n") && city == nil
      #     street_arr = street.split("\n")
      #     street = street_arr[0]
      #     city = street_arr[1]
      # end

      ### NEED HELP.  NOT REACTING, BUT WORKS ON REPL.
      ### http://www.avondalenissan.com
      ### http://www.germainnissan.com
      ### STREET: "4300 Morse Rd  \nColumbus, OH, 43230"
      street = store_info_helper(street) unless nil
      city = store_info_helper(city) unless nil
      state = store_info_helper(state) unless nil
      zip = store_info_helper(zip) unless nil

      info = [street, city, state, zip]
    end
  end

  def store_info_helper(item)
    if item
      item.gsub!("  ", " ")
      item.gsub!("\t", "")
      item.gsub!("\n", "")
      item.strip!
      item
    end
  end

  def copyright_extractor(copyright)
    ### FOR DealerFire RTS: Extracts org from copyright footer.
    if copyright && (copyright.include?("©") || copyright.include?("Copyright"))
      copyright_arr = copyright.split("©")
      if copyright_arr[1].include?("\n")
        copyright_arr = copyright_arr[1].split("\n")
        copyright = copyright_arr[0].gsub!(/[^A-Za-z]/, " ")
        copyright.strip!
      end
    end
    copyright
  end
end
