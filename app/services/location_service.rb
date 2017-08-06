class LocationService

  def geo_places_starter
    ## ORIGINAL IS BASED ON "CORES".  THIS IS BASED ON "LOCATIONS".
    
    ## TEMPORARY - FOR RE-RUNNING WRONG ACCOUNT NAME RESULTS
    # locations = Location.where(crm_source: "Web").where("geo_acct_name != acct_name").where("address != geo_full_addr").where.not(location_status: "Re-Run Failed").where.not(location_status: "Spots: Empty")[200..-1]

    locations = Location.where(crm_source: "CRM").where("geo_acct_name != acct_name").where("address = geo_full_addr")[0..0]


    counter = 0
    locations.each do |location|
      counter += 1
      puts
      puts "=========== #{counter} ==========="
      puts
      # puts "----- GEO (original) -----"
      # puts "Name: #{location.geo_acct_name}"
      # puts "Addr: #{location.geo_full_addr}"
      # puts "URL: #{location.url}"
      puts "----- CRM (original) -----"
      puts "Name: #{location.acct_name}"
      puts "Addr: #{location.address}"
      puts "URL: #{location.crm_url}"

      get_spot(location)
    end

    ## GETS LOCATIONS WITHOUT IMAGE
    # locations = Location.where(img_url: nil).where.not(postal_code: nil).where.not(location_status: "IMG Search")[30000..-1]
    # counter = 0
    # locations.each do |location|
    #     counter += 1
    #     puts "----- #{counter} -------"
    #     get_spot(location)
    # end


  end


  # def get_spot(core)
  def get_spot(location)
    client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])

    # if location.address != nil
    #     custom_query = "#{location.acct_name} near #{location.address}"
    # else
    #     custom_query = location.acct_name
    # end

    crm_url = location.crm_url

    crm_acct = location.acct_name
    geo_acct = location.geo_acct_name

    if crm_acct && crm_acct != geo_acct
      spots = client.spots_by_query(crm_acct, types: ["car_dealer"])
    elsif crm_url && crm_url != ""

      uri = URI(crm_url)
      host = uri.host

      if host
        if host.include?("www.")
          short_host = host.gsub("www.", "")
        else
          short_host = host
        end
      end

      spots = client.spots_by_query(short_host, types: ["car_dealer"])
    else
      puts "Re-Run Failed"
      location.update_attribute(:sts_duplicate, "No Results")
      return
    end


    if spots.empty?
      # core.update_attributes(bds_status: "Geo Error", geo_status: "Geo Error", geo_date: Time.new)
      puts "Spots: Empty"
      # location.update_attribute(:location_status, "IMG Search")
      location.update_attribute(:sts_duplicate, "No Results")
      return
    else
      spot = spots.first
      detail = client.spot(spot.reference)
      create_geo_place(location, spot, detail)
    end
  end

  def create_geo_place(location, spot, detail)
    # puts
    # puts "----- GEO (new) -----"
    # puts "Name: #{spot.name}"

    formatted_address = detail.formatted_address
    if formatted_address.include?(", United States")

      new_formatted_address = formatted_address.gsub(", United States", "").strip
      new_formatted_address_arr = new_formatted_address.split(",")

      street = new_formatted_address_arr[0].strip
      street.include?("Street") ? street.gsub!("Street", "St") : street
      street.include?("Avenue") ? street.gsub!("Avenue", "Ave") : street
      street.include?("Highway") ? street.gsub!("Highway", "Hwy") : street
      street.include?("Boulevard") ? street.gsub!("Boulevard", "Blvd") : street
      street.include?("Road") ? street.gsub!("Road", "Rd") : street
      street.include?("Drive") ? street.gsub!("Drive", "Dr") : street
      street.include?("Lane") ? street.gsub!("Lane", "Ln") : street

      city = new_formatted_address_arr[-2].strip
      state_zip_arr = new_formatted_address_arr[-1].split(" ")
      state = state_zip_arr[0]
      zip = state_zip_arr[1]

      unless street == city || city == state || state == zip
        street != nil || street != "" ? street_if = "#{street}, " : street_if = nil
        city != nil || city != "" ? city_if = "#{city}, " : city_if = nil
        state != nil || state != "" ? state_if = "#{state}, " : state_if = nil
        new_full_address = street_if+city_if+state_if+zip
        # puts "Addr: #{new_full_address}"
      else
        new_full_address = "Error: Duplicate Components"
        # puts "Addr: #{new_full_address}"
      end

      img = detail.photos[0]
      img_url = img ? img.fetch_url(300) : nil
      coordinates = "#{spot.lat}, #{spot.lng}"

      raw_url = detail.website
      if raw_url

        if raw_url.include?("www.")
          url = raw_url
        else
          url = raw_url.gsub("//", "//www.")
        end

        uri = URI(url)
        full_url = "#{uri.scheme}://#{uri.host}"

        host_parts = uri.host.split(".")
        root = host_parts[1]

        # puts
        # puts
        # puts "New: #{root}"
        # puts "New: #{full_url}"
        # puts "--------------------"
      end

      raw_crm_url = location.crm_url
      if raw_crm_url

        if raw_crm_url.include?("www.")
          crm_url = raw_crm_url
        else
          crm_url = raw_crm_url.gsub("//", "//www.")
        end

        uri = URI(crm_url)
        uri_crm_url = "#{uri.scheme}://#{uri.host}"
      end

      if uri_crm_url
        if uri_crm_url[-1, 1] == ("/")
          clean_crm_url = uri_crm_url[0...-1]
        else
          clean_crm_url = uri_crm_url
        end
      end

      # puts "CRM: #{clean_crm_url}"

      puts
      puts "----- GEO (UPDATED) -----"
      puts "Name: #{spot.name}"
      puts "Addr: #{new_full_address}"
      puts "URL: #{clean_crm_url}"
      puts

      acct_name = location.acct_name
      geo_acct_name = location.geo_acct_name
      if acct_name == geo_acct_name
        final_name = acct_name
      else
        final_name = spot.name
      end

      address = location.address
      geo_full_addr = location.geo_full_addr
      if address == geo_full_addr
        final_address = address
      else
        final_address = new_full_address
      end

      url = location.url
      crm_url = location.crm_url
      if crm_url == url
        final_url = crm_url
      else
        final_url = clean_crm_url
      end

      crm_phone = location.crm_phone
      phone = location.phone
      if crm_phone == phone
        final_phone = crm_phone
      else
        final_phone = detail.formatted_phone_number
      end


      # if clean_crm_url == full_url

      if new_full_address == location.geo_full_addr
        location.update_attributes(geo_acct_name: spot.name, url: clean_crm_url)
      end


      # location.update_attributes(img_url: img_url, latitude: spot.lat, longitude: spot.lng, street: street, city: city, coordinates: coordinates, state_code: state, postal_code: zip, geo_acct_name: final_name, phone: final_phone, map_url: detail.url, geo_full_addr: final_address, url: final_url, geo_root: root, location_status: "Geo Result", coord_id_arr: sfdc_id_finder(coordinates), sts_duplicate: "Result")

      # else
      #     location.update_attributes(img_url: img_url, latitude: spot.lat, longitude: spot.lng, street: street, city: city, coordinates: coordinates, state_code: state, postal_code: zip, geo_acct_name: spot.name, phone: detail.formatted_phone_number, map_url: detail.url, geo_full_addr: new_full_address, url: full_url, geo_root: root, coord_id_arr: sfdc_id_finder(coordinates), sts_duplicate: "Result")
      # end
      #
      # new_geo_acct_name = location.geo_acct_name
      # if acct_name == new_geo_acct_name
      #     puts "Acct: Matched"
      # else
      #     puts "Acct: X"
      # end
      #
      # new_geo_full_addr = location.geo_full_addr
      # if address == new_geo_full_addr
      #     puts "Addr: Matched"
      # else
      #     puts "Addr: X"
      # end
      #
      # new_url = location.url
      # if crm_url == new_url
      #     puts "URL: Matched"
      # else
      #     puts "URL: X"
      # end
      #
      # new_phone = location.phone
      # if crm_phone == new_phone
      #     puts "Phone: Matched"
      # else
      #     puts "Phone: X"
      # end
      #



      # img = detail.photos[0]
      # img_url = img ? img.fetch_url(300) : nil
      # puts img_url

      # location.update_attributes(img_url: img_url, location_status: "IMG Search")
      #
      # cores = Core.where(sfdc_id: location.sfdc_id)
      # cores.each do |core|
      #     core.update_attribute(:img_url, img_url)
      # end


      # Location.create(latitude: spot.lat, longitude: spot.lng, street: street, city: city, coordinates: coordinates, acct_name: core.sfdc_acct, state_code: state, postal_code: zip, group_name: core.sfdc_group, ult_group_name: core.sfdc_ult_grp, source: "GEO", sfdc_id: core.sfdc_id, tier: core.sfdc_tier, sales_person: core.sfdc_sales_person, acct_type: core.sfdc_type, crm_root: core.sfdc_root, address: core.full_address, location_status: status, geo_acct_name: spot.name, phone: detail.formatted_phone_number, map_url: detail.url, hierarchy: "GEO", geo_full_addr: geo_address, crm_source: core.alt_source, url: full_url, geo_root: root, crm_url: core.sfdc_url, crm_franch_term: core.sfdc_franchise, crm_franch_cons: core.sfdc_franch_cons, crm_franch_cat: core.sfdc_franch_cat, crm_phone: core.sfdc_ph, crm_hierarchy: core.hierarchy, geo_type: "Geo Result", coord_id_arr: sfdc_id_finder(coordinates))


      ## core.update_attributes(bds_status: status, geo_status: status, geo_date: Time.new)

    end

  end


  ######## CAUTION - SAVE ABOVE THIS LINE!  ##########


  def sts_duplicate_tagger
    locs = Location.where("address = geo_full_addr").where("acct_name = geo_acct_name")
    Location.where("address LIKE '%.%'").count


    counter=0
    locs.each do |loc|
      crm_source = loc.crm_source
      sfdc_id = loc.sfdc_id
      duplicate_arr = loc.duplicate_arr
      url_arr = loc.url_arr
      cop_franch_arr = loc.cop_franch_arr

      target_source_arr = []

      duplicate_arr.each do |target|
        ids = Location.where(sfdc_id: target)
        ids.each do |id|
          target_source_arr << id.crm_source
        end
      end

      if target_source_arr.include?("CRM")
        group_source_target = "CRM"
      elsif target_source_arr.include?("Cop")
        group_source_target = "Cop"
      elsif target_source_arr.include?("Web")
        group_source_target = "Web"
      end


      if group_source_target == "CRM"
        if crm_source == "CRM"
          sts_duplicate = "Save"
        else
          sts_duplicate = "Delete"
        end
      elsif group_source_target == "Cop"
        if crm_source == "Cop"
          sts_duplicate = "Save"
        else
          sts_duplicate = "Delete"
        end
      elsif group_source_target == "Web"
        if crm_source == "Web"
          sts_duplicate = "Save"
        else
          sts_duplicate = "Delete"
        end
      end


      counter+=1
      puts
      puts
      puts "=========== #{counter} ==========="
      puts
      puts "duplicate_arr: #{duplicate_arr}"
      puts "group_source_target: #{group_source_target}"
      puts
      puts "-----------------------"
      puts "ID: #{sfdc_id}"
      puts "Source: #{crm_source}"
      puts "sts_duplicate: #{sts_duplicate}"
      puts "-----------------------"
      puts
      puts "url_arr: #{url_arr}"
      puts "cop_franch_arr: #{cop_franch_arr}"
      puts
      loc.update_attribute(:sts_duplicate, sts_duplicate)


    end
  end


  def cop_franch_migrator
    locations = Location.where(crm_source: "Cop")
    counter=0
    locations.each do |loc|

      cores = Core.where(sfdc_id: loc.sfdc_id)
      cores.each do |core|
        counter+=1
        puts "=========== #{counter} ==========="
        core_cop_franch = core.cop_franch
        core_cop_franch_arr = core_cop_franch.split(";")

        puts core_cop_franch
        puts "----"
        puts core_cop_franch_arr
        puts "----"

        # loc.update_attributes(cop_franch: core_cop_franch, cop_franch_arr: core_cop_franch_arr)

        puts "**"
        loc_cop_franch = loc.cop_franch
        puts loc_cop_franch
        puts "**"
        loc_cop_franch_arr = loc.cop_franch_arr
        puts loc_cop_franch_arr
        puts

      end
    end
  end


  def db_check
    locs = Location.where(sfdc_id: "web1485120753040")
    locs.each do |loc|
      puts "===================================="
      puts loc.url_arr
      puts "----------"
      puts loc.duplicate_arr
      puts "----------"
      puts loc.cop_franch_arr
      puts "----------"
    end
  end


  def duplicate_match_collector
    locs = Location.where("address = geo_full_addr").where("acct_name = geo_acct_name")[40627..-1]

    counter=40627
    locs.each do |loc|

      crm_acct = loc.acct_name
      crm_addr = loc.address
      coordinates = loc.coordinates

      url_arr = loc.url_arr unless loc.url_arr == nil
      franchise_tank = loc.cop_franch_arr
      duplicate_arr = duplicate_acct_finder(crm_acct, crm_addr, coordinates).sort

      counter+=1
      puts
      puts
      puts "============= (#{counter}) =============="
      puts "****** #{loc.sfdc_id}"
      puts
      puts duplicate_arr
      puts

      duplicate_arr.each do |duplicate|

        ids = Location.where(sfdc_id: duplicate)
        ids.each do |id|

          puts "----------------"
          puts id.sfdc_id
          puts id.coordinates
          puts id.acct_name
          puts id.address
          puts id.url
          puts id.crm_url
          puts id.phone
          puts id.crm_phone

          dup_geo_url = id.url
          if dup_geo_url
            url_arr << dup_geo_url unless url_arr.include?(dup_geo_url)
          end

          dup_crm_url = id.crm_url
          if dup_crm_url
            url_arr << dup_crm_url unless url_arr.include?(dup_crm_url)
          end

          cop_franchises = id.cop_franch_arr
          if cop_franchises
            puts
            puts cop_franchises
            puts
            cop_franchises.each do |franch|
              franchise_tank << franch unless franchise_tank.include?(franch)
            end
          end

        end

      end

      puts
      puts "1"
      unless url_arr == nil || url_arr == []
        final_url_arr = url_arr.sort unless url_arr == nil
        puts final_url_arr
      end
      puts

      puts "3"
      unless franchise_tank == nil || franchise_tank == []
        final_cop_franch_arr = franchise_tank.sort
        puts final_cop_franch_arr
      end
      puts

      loc.update_attributes(duplicate_arr: duplicate_arr, cop_franch_arr: final_cop_franch_arr, url_arr: final_url_arr)

    end
  end


  def duplicate_acct_finder(acct_name, address, coordinates)
    Location.where(coordinates: coordinates, address: address, acct_name:acct_name).map(&:sfdc_id)
  end


  def quick_coordinates_collector
    # Uses .map method to create collections of ids with same coords.
    locations = Location.where.not(coordinates: nil)
    counter=0
    locations.each do |loc|

      current_collection = loc.coord_id_arr.sort
      new_collection = sfdc_id_finder(loc.coordinates).sort

      if current_collection == new_collection
        # puts "Same"
      else
        puts "==================="
        counter+=1
        puts "Updated (#{counter})"
        puts
        puts "----- Current ------"
        puts current_collection
        puts "------- New ------"
        puts new_collection
        puts
        loc.update_attribute(:coord_id_arr, new_collection)
      end

    end

  end


  def sfdc_id_finder(coordinates)
    Location.where(coordinates: coordinates).map(&:sfdc_id)
  end


  def phone_updater
    locations = Location.where("crm_phone != phone").where("acct_name = geo_acct_name")
    counter=0
    locations.each do |loc|

      crm_acct = loc.acct_name
      crm_url = loc.crm_url
      crm_address = loc.address
      crm_phone = loc.crm_phone

      geo_acct = loc.geo_acct_name
      geo_url = loc.url
      geo_address = loc.geo_full_addr
      geo_phone = loc.phone

      counter +=1
      puts
      puts
      puts "===================== #{counter} ====================="
      puts
      puts crm_acct
      puts geo_acct

      puts crm_url
      puts geo_url

      puts crm_address
      puts geo_address

      puts crm_phone
      puts geo_phone
      puts
      puts

      loc.update_attribute(:crm_phone, loc.phone)


    end
  end


  def duplicate_sts_btn
    # resets = Location.where(sts_duplicate: "Duplicate")
    # resets.each do |reset|
    #     puts "reset"
    #     reset.update_attribute(:sts_duplicate, "None")
    # end


    matches = Location.where(sts_geo_crm: "Matched-4")
    counter = 0
    matches.each do |match|

      locations = Location.where(sts_geo_crm: match.sts_geo_crm, acct_name: match.acct_name, crm_url: match.crm_url, address: match.address, crm_phone: match.crm_phone).where.not(sfdc_id: match.sfdc_id)

      locations.each do |location|

        match_sts_geo_crm = match.sts_geo_crm
        match_crm_source = match.crm_source
        match_acct_name = match.acct_name
        match_crm_url = match.crm_url
        match_address = match.address
        match_crm_phone = match.crm_phone
        match_sfdc_id = match.sfdc_id

        loc_sts_geo_crm = location.sts_geo_crm
        loc_crm_source = location.crm_source
        loc_acct_name = location.acct_name
        loc_crm_url = location.crm_url
        loc_address = location.address
        loc_crm_phone = location.crm_phone
        loc_sfdc_id = location.sfdc_id

        counter +=1
        puts
        puts
        puts "===================== #{counter} ====================="
        puts
        puts "-------------- Match --------------"
        puts match_sts_geo_crm
        puts match_crm_source
        puts match_sfdc_id
        puts match_acct_name
        puts match_crm_url
        puts match_address
        puts match_crm_phone
        puts
        puts "------------ Location ------------"
        puts loc_sts_geo_crm
        puts loc_crm_source
        puts loc_sfdc_id
        puts loc_acct_name
        puts loc_crm_url
        puts loc_address
        puts loc_crm_phone
        puts
        puts

        match.update_attribute(:sts_duplicate, "Duplicate")
        location.update_attribute(:sts_duplicate, "Duplicate")

      end

    end

  end


  def sts_updater
    locations = Location.all
    counter = 0
    locations.each do |location|

      location.update_attribute(:sts_geo_crm, nil)

      url = location.url
      crm_url = location.crm_url
      geo_acct = location.geo_acct_name
      crm_acct = location.acct_name
      geo_addr = location.geo_full_addr
      crm_addr = location.address
      geo_phone = location.phone
      crm_phone = location.crm_phone

      matched_arr = []
      if url == crm_url
        sts_url = "Matched"
        matched_arr << sts_url
      else
        sts_url = "None"
      end

      if geo_acct == crm_acct
        sts_acct = "Matched"
        matched_arr << sts_acct
      else
        sts_acct = "None"
      end

      if geo_addr == crm_addr
        sts_addr = "Matched"
        matched_arr << sts_addr
      else
        sts_addr = "None"
      end

      if geo_phone == crm_phone
        sts_ph = "Matched"
        matched_arr << sts_ph
      else
        sts_ph = "None"
      end

      sts_geo_crm = "Matched-#{matched_arr.length}"
      counter +=1
      puts
      puts "--------------- #{counter} -------------------"
      puts geo_acct
      puts "sts_url: #{sts_url}"
      puts "sts_acct: #{sts_acct}"
      puts "sts_addr: #{sts_addr}"
      puts "sts_ph: #{sts_ph}"
      puts "sts_geo_crm: #{sts_geo_crm}"
      puts

      location.update_attributes(sts_url: sts_url, sts_acct: sts_acct, sts_addr: sts_addr, sts_ph: sts_ph, sts_geo_crm: sts_geo_crm)

    end


  end


  def turbo_matcher
    locations = Location.where(crm_source: "Web")

    counter = 0
    locations.each do |location|
      cores = Core.where(sfdc_id: location.sfdc_id)
      cores.each do |core|

        geo_acct = location.geo_acct_name
        geo_full_addr = location.geo_full_addr
        geo_street = location.street
        geo_city = location.city
        geo_state = location.state_code
        geo_zip = location.postal_code
        geo_url = location.url
        geo_root = location.geo_root
        geo_phone = location.phone

        crm_acct = location.acct_name
        crm_full_addr = location.address
        crm_street = location.crm_street
        crm_city = location.crm_city
        crm_state = location.crm_state
        crm_zip = location.crm_zip
        crm_root = location.crm_root
        crm_url = location.crm_url
        crm_phone = location.crm_phone
        crm_source = location.crm_source
        core_staffer = core.staffer_sts

        if crm_source == "Web" && core_staffer == "Web Contacts" && crm_root == geo_root
          if geo_acct != crm_acct
            counter += 1
            puts "------------- #{counter} -------------"
            puts
            puts "GEO: #{geo_acct}"
            puts "CRM: #{crm_acct}"
            puts
            location.update_attribute(:acct_name, location.geo_acct_name)

            if geo_full_addr != crm_full_addr
              puts "GEO: #{geo_full_addr}"
              puts "CRM: #{crm_full_addr}"
              puts
              location.update_attributes(address: location.geo_full_addr, crm_street: location.street, crm_city: location.city, crm_state: location.state_code, crm_zip: location.postal_code)
            end

            if geo_phone != crm_phone
              puts "GEO: #{geo_phone}"
              puts "CRM: #{crm_phone}"
              location.update_attribute(:crm_phone, location.phone)
            end

          end
        end
      end
    end

  end



  def root_matcher
    ### COME BACK TO THIS!! 3,500 MATCHING URLS!  BUT HAVE TWO VALID URLS!  NEED TO SAVE BOTH.
    # locations = Location.where("acct_name = geo_acct_name").where("address = geo_full_addr").where.not("url = crm_url")[0..200]


    # locations = Location.where("crm_root != geo_root").where("url = crm_url")
    # locations = Location.where("url != crm_url")[0..20]
    # locations = Location.where("url != crm_url").where(crm_source: "CRM").where.not("crm_url LIKE '%http%' OR crm_url != 'nil'")
    # locations = Location.where(crm_url: nil).where.not(url: nil).where("address = geo_full_addr").where("acct_name = geo_acct_name")
    # locations = Location.where("url != crm_url").where.not("crm_url_redirect LIKE '%http%'").where("geo_url_redirect LIKE '%http%'")
    # locations = Location.where("acct_name = geo_acct_name").where("address != geo_full_addr").where("url = crm_url")

    # locations = Location.where.not(phone: nil).where("phone != crm_phone").where("url = crm_url").where("acct_name = geo_acct_name").where("address = geo_full_addr")


    # models = Location.where(sts_geo_crm: "Matched-4")
    # model_count = 0
    # models.each do |model|
    # model_count +=1

    # locations = Location.where(coordinates: model.coordinates).where.not(sts_geo_crm: "Matched-4").where(crm_source: "Web").where(crm_url: model.url)

    # locations = Location.where(coordinates: model.coordinates).where.not(sts_geo_crm: "Matched-4").where(crm_url: nil).where(acct_name: model.acct_name)

    locations = Location.where(crm_url: nil).where.not(url: nil).where.not(sts_geo_crm: "Matched-0").where.not(sts_geo_crm: nil)


    counter = 0
    locations.each do |location|

      geo_acct = location.geo_acct_name
      geo_addr = location.geo_full_addr
      geo_phone = location.phone
      geo_root = location.geo_root
      url = location.url
      geo_red = location.geo_url_redirect

      crm_sts = location.sts_geo_crm
      crm_acct = location.acct_name
      crm_addr = location.address
      crm_phone = location.crm_phone
      crm_root = location.crm_root
      crm_url = location.crm_url
      crm_red = location.crm_url_redirect
      crm_source = location.crm_source

      # mod_sts = model.sts_geo_crm
      # mod_acct = model.geo_acct_name
      # mod_addr = model.geo_full_addr
      # mod_root = model.geo_root
      # mod_url = model.url
      # mod_phone = model.phone


      counter +=1
      puts
      puts
      puts "====== (#{counter}) ============"
      puts
      # puts "M-Sts/ID: #{mod_sts} (#{model.sfdc_id})"
      puts "C-Sts/ID: #{crm_sts} (#{location.sfdc_id})"
      # puts "C-URL: #{crm_url}"
      # puts "G-URL: #{url}"
      puts "---------------------------"
      puts

      unless url == crm_url
        puts "------ Different ------"
        puts "C-URL: #{crm_url}"
        # puts "M-Acct: #{mod_url}"
        puts "G-URL: #{url}"
        puts
        location.update_attribute(:crm_url, url)
      else
        puts "Same URL: #{url}"
        puts
      end

      unless geo_acct == crm_acct
        puts "------ Different ------"
        puts "C-Acct: #{crm_acct}"
        # puts "M-Acct: #{mod_acct}"
        puts "G-Acct: #{geo_acct}"
        puts
        location.update_attribute(:acct_name, geo_acct)
      else
        puts "Same Acct: #{geo_acct}"
        puts
      end

      unless geo_addr == crm_addr
        puts "C-Addr: #{crm_addr}"
        # puts "M-Addr: #{mod_addr}"
        puts "G-Addr: #{geo_addr}"
        puts
        location.update_attribute(:address, geo_addr)
      else
        puts "Same Addr: #{geo_addr}"
        puts
      end

      unless geo_phone == crm_phone
        puts "C-PH: #{crm_phone}"
        # puts "M-PH: #{mod_phone}"
        puts "G-PH: #{geo_phone}"
        puts
        location.update_attribute(:crm_phone, geo_phone)
      else
        puts "Same Phone: #{geo_phone}"
        puts
      end

      puts



      # location.update_attributes(crm_phone: geo_phone, acct_name: geo_acct, address: geo_addr, crm_url: location.url)
    end

    # end

  end


  def coord_id_arr_btn
    locations = Location.where.not(coordinates: nil)

    locations.each do |location|
      new_ids = sfdc_id_finder(location.coordinates)
      ids = location.coord_id_arr
      if ids != new_ids
        puts "\n\n(1) ids: #{ids}, new_ids: #{new_ids}\n\n"
        ids = new_ids
      end

      ids.each do |id|
        locs = Location.where(sfdc_id: id)

        locs.each do |loc|
          puts "\n\n(2) ids: #{ids}, id: #{id}, locs#: #{locs.count}, loc.coord_id_arr: #{loc.coord_id_arr}\n\n"
          if loc.coord_id_arr != ids
            puts "\n\n(3) loc.coord_id_arr: #{loc.coord_id_arr}, ids: #{ids}\n\n"
            # loc.update_attribute(:coord_id_arr, ids)
          end
        end
      end
    end
  end


  def root_and_url_finalizer
    # Ensures all urls have www, end after suffix (.com/), and gets root if updated.  Counts array items to get root at correct place.
    # locations = Location.where.not(crm_url: nil).where.not(crm_url: "").where.not("crm_url LIKE '%www.%'")
    # locations = Location.where("url LIKE '%http%'").where("crm_url LIKE '%http%'").where("geo_url_redirect LIKE '%http%'")

    locations = Location.all

    diff_count = 0
    total = 0
    new_match_counter = 0
    locations.each do |location|
      total +=1

      ## CRM URL HASH
      crm_url_pre = location.crm_url
      if crm_url_pre && crm_url_pre.include?("http")
        crm_url = crm_url_pre
        crm_root = location.crm_root
      end

      if url_formatter(crm_url)
        crm_url_hash = url_formatter(crm_url)
        new_crm_url = crm_url_hash[:new_url]
        new_crm_root = crm_url_hash[:new_root]
      end

      ## GEO URL HASH
      geo_url_pre = location.url
      if geo_url_pre && geo_url_pre.include?("http")
        geo_url = geo_url_pre
        geo_root = location.geo_root
      end

      if url_formatter(geo_url)
        geo_url_hash = url_formatter(geo_url)
        new_geo_url = geo_url_hash[:new_url]
        new_geo_root = geo_url_hash[:new_root]
      end

      ## CRM REDIRECT HASH
      crm_redirect_pre = location.crm_url_redirect
      if crm_redirect_pre && crm_redirect_pre.include?("http")
        crm_url_redirect = crm_redirect_pre
      end

      if url_formatter(crm_url_redirect)
        crm_url_redirect_hash = url_formatter(crm_url_redirect)
        new_crm_redirect_url = crm_url_redirect_hash[:new_url]
        new_crm_redirect_root = crm_url_redirect_hash[:new_root]
      end

      ## GEO REDIRECT HASH
      geo_redirect_pre = location.geo_url_redirect
      if geo_redirect_pre && geo_redirect_pre.include?("http")
        geo_url_redirect = geo_redirect_pre
      end

      if url_formatter(geo_url_redirect)
        geo_url_redirect_hash = url_formatter(geo_url_redirect)
        new_geo_redirect_url = geo_url_redirect_hash[:new_url]
        new_geo_redirect_root = geo_url_redirect_hash[:new_root]
      end


      if new_crm_redirect_url && new_crm_redirect_url != new_crm_url
        diff_count +=1
        puts "========= CRM: (#{diff_count}/#{total}) === #{location.sfdc_id} ===="
        puts
        if new_crm_url
          puts "O: #{new_crm_url}"
        else
          puts "P: #{crm_url_pre}"
        end
        puts "N: #{new_crm_redirect_url}"
        puts
        if new_crm_root
          puts "O: #{new_crm_root}"
        end
        puts "N: #{new_crm_redirect_root}"
        puts
        if new_crm_redirect_root == geo_root
          new_match_counter +=1
          puts "======== CRM-GEO MATCH!!! (#{new_match_counter}) ======== "
          puts
        end
        puts
        puts
        location.update_attributes(crm_url: new_crm_redirect_url, crm_root: new_crm_redirect_root)
      end

      if new_geo_redirect_url && new_geo_redirect_url != new_geo_url
        diff_count +=1
        puts "========= GEO: (#{diff_count}/#{total}) === #{location.sfdc_id} ===="
        puts
        if new_geo_url
          puts "O: #{new_geo_url}"
        else
          puts "P: #{geo_url_pre}"
        end
        puts "N: #{new_geo_redirect_url}"
        puts
        if new_geo_root
          puts "O: #{new_geo_root}"
        end
        puts "N: #{new_geo_redirect_root}"
        puts
        if new_geo_redirect_root == crm_root
          new_match_counter +=1
          puts "======== CRM-GEO MATCH!!! (#{new_match_counter}) ========"
          puts
        end
        puts
        puts
        location.update_attributes(url: new_geo_redirect_url, geo_root: new_geo_redirect_root)
      end

    end
  end


  def web_acct_name_cleaner
    # terms = InHostPo.all
    # terms.each do |term|
    locations = Location.where(crm_source: "Web").where("geo_acct_name != acct_name")[0..10]

    locations.each do |location|

      cores = Core.where(sfdc_id: location.sfdc_id).where.not(staffer_sts: 'Web Contacts').where(alt_source: 'Web')

      counter = 0
      cores.each do |core|

        geo_acct = location.geo_acct_name
        geo_full_addr = location.geo_full_addr
        geo_street = location.street
        geo_city = location.city
        geo_state = location.state_code
        geo_zip = location.postal_code
        geo_url = location.url
        geo_root = location.geo_root
        geo_phone = location.phone

        crm_acct = location.acct_name
        crm_full_addr = location.address
        crm_street = location.crm_street
        crm_city = location.crm_city
        crm_state = location.crm_state
        crm_zip = location.crm_zip
        crm_root = location.crm_root
        crm_url = location.crm_url
        crm_phone = location.crm_phone
        crm_source = location.crm_source
        core_staffer = core.staffer_sts

        # if crm_source == "Web" && core_staffer == "Web Contacts" && crm_root == geo_root
        # if geo_acct != crm_acct
        counter += 1
        puts "------------- #{counter} -------------"
        puts
        puts "GEO: #{geo_acct}"
        puts "CRM: #{crm_acct}"
        puts
        # location.update_attribute(:acct_name, location.geo_acct_name)

        if geo_full_addr != crm_full_addr
          puts "GEO: #{geo_full_addr}"
          puts "CRM: #{crm_full_addr}"
          puts
          # location.update_attributes(address: location.geo_full_addr, crm_street: location.street, crm_city: location.city, crm_state: location.state_code, crm_zip: location.postal_code)
        end

        if geo_phone != crm_phone
          puts "GEO: #{geo_phone}"
          puts "CRM: #{crm_phone}"
          # location.update_attribute(:crm_phone, location.phone)
        end

        # end
        # end
      end
    end

    # end


  end


  def street_cleaner
    ## changes long street type to short type.
    ## locations = Location.where("address LIKE '%Street%'")

    # locations = Location.where.not(address: nil)
    #
    # counter = 0
    # locations.each do |location|
    #
    #     crm_full_addr = location.address
    #     crm_full_addr_o = crm_full_addr
    #     crm_full_addr_n = street_cleaner_formatter(crm_full_addr)
    #
    #     geo_full_addr = location.geo_full_addr
    #     geo_full_addr_o = geo_full_addr
    #     geo_full_addr_n = street_cleaner_formatter(geo_full_addr)
    #
    #     geo_street = location.street
    #     geo_street_o = geo_street
    #     geo_street_n = street_cleaner_formatter(geo_street)

    # if crm_full_addr_n || geo_full_addr_n || geo_street_n
    #     counter +=1
    #     puts "-------- #{counter} ------------"
    #
    #     if crm_full_addr_n
    #         puts "CRM: #{crm_full_addr_n}"
    #         location.update_attribute(:address, crm_full_addr_n)
    #     end
    #
    #     if geo_full_addr_n
    #         puts "GEO: #{geo_full_addr_n}"
    #         location.update_attribute(:geo_full_addr, geo_full_addr_n)
    #     end
    #
    #     if geo_street_n
    #         puts "GEO: #{geo_street_n}"
    #         location.update_attribute(:street, geo_street_n)
    #     end
    # end
    # end
  end


  def street_cleaner_formatter(street)
    # if street
    #     if street.include?("Street")
    #         street_sub = street.gsub("Street", "St")
    #     elsif street.include?("Highway")
    #         street_sub = street.gsub("Highway", "Hwy")
    #     elsif street.include?("Boulevard")
    #         street_sub = street.gsub("Boulevard", "Blvd")
    #     elsif street.include?("Road")
    #         street_sub = street.gsub(" Road", " Rd")
    #     elsif street.include?("Drive")
    #         street_sub = street.gsub("Drive", "Dr")
    #     elsif street.include?("Lane")
    #         street_sub = street.gsub("Lane", "Ln")
    #     elsif street.include?("Parkway")
    #         street_sub = street.gsub("Parkway", "Pkwy")
    #     elsif street.include?("Expressway")
    #         street_sub = street.gsub("Expressway", "Expy")
    #     elsif street.include?("Route")
    #         street_sub = street.gsub("Route", "Rte")
    #     end
    # end
  end


  def url_redirect_checker
    require 'curb'

    # locations = Location.where.not(crm_url: nil).where.not(crm_url: "").where("url != crm_url").where(crm_url_redirect: nil)

    # Location.where("geo_root = crm_root")

    # locations = Location.where.not(crm_url: nil).where.not(crm_url: "").where("url != crm_url").where(geo_url_redirect: nil)[20...-1]

    counter_result = 0
    counter_fail = 0
    match_counter = 0
    total = 0
    locations.each do |location|
      total +=1

      geo_url_first = location.crm_url

      unless geo_url_first == nil || geo_url_first == ""
        begin ## rescue
          result = Curl::Easy.perform(geo_url_first) do |curl|
            curl.follow_location = true
            curl.useragent = "curb"
            # curl.ssl_verify_peer = false
          end

          curb_url_result = result.last_effective_url

          crm_url_hash = url_formatter(curb_url_result)
          crm_url_final = crm_url_hash[:new_url]
          geo_root_final = crm_url_hash[:new_root]

          crm_root = location.crm_root
          crm_source = location.crm_source

          if geo_url_first != crm_url_final
            counter_result +=1
            puts "======= #{crm_source}: (#{counter_result}/#{total}) ======="
            puts
            puts "O: #{geo_url_first}"
            puts "N: #{crm_url_final}"

            if geo_root_final == crm_root
              match_counter +=1
              puts
              puts
              puts "NEW MATCH --- !!!!!!! --- (#{match_counter})"
              puts
              puts geo_root_final
              puts crm_root
              puts
              puts
            end
            location.update_attribute(:crm_url_redirect, geo_url_final)
            puts
            puts "==================================="
          else
            puts "(#{total}) #{crm_source}: Same"
            location.update_attribute(:crm_url_redirect, geo_url_final)
          end

        rescue  #begin rescue
          # $!.message
          # puts $!.message
          error_message = $!.message
          counter_fail +=1
          puts "(#{counter_fail}/#{total}) #{crm_source} ERROR (#{error_message})"
          location.update_attribute(:geo_url_redirect, error_message)
        end  #end rescue
      end

    end

  end


  def url_formatter(url)
    unless url == nil || url == ""
      url.gsub!(/\P{ASCII}/, '')
      url = remove_slashes(url)
      if url.include?("\\")
        url_arr = url.split("\\")
        url = url_arr[0]
      end
      unless url.include?("www.")
        url = url.gsub!("//", "//www.")
      else
        url
      end

      uri = URI(url)
      new_url = "#{uri.scheme}://#{uri.host}"

      if uri.host
        host_parts = uri.host.split(".")
        new_root = host_parts[1]
      end
      return {new_url: new_url, new_root: new_root}
    end
  end


  def remove_slashes(url)
    # For rare cases w/ urls with mistaken double slash twice.
    parts = url.split('//')
    if parts.length > 2
      return parts[0..1].join
    end
    url
  end


  def sts_duplicate_nil
    locs = Location.where.not(sts_duplicate: nil)
    locs.each do |loc|
      puts loc.sts_duplicate
      loc.update_attribute(:sts_duplicate, nil)
      puts loc.sts_duplicate
    end
  end


  def url_dup_finder
    locs = Location.where("acct_name = geo_acct_name").where("geo_full_addr = address").where("url = crm_url").where(crm_source: "CRM")[0..0]

    counter=0
    locs.each do |loc|

      merges = Location.where.not(sfdc_id: loc.sfdc_id).where(acct_name: loc.acct_name).where(address: loc.address).where(crm_url: loc.crm_url).where(crm_source: "Cop")
      merges.each do |merge|
        keep_source = loc.crm_source
        keep_id = loc.sfdc_id
        keep_name = loc.acct_name
        keep_url = loc.crm_url
        keep_addr = loc.address

        cop_source = merge.crm_source
        cop_id = merge.sfdc_id
        cop_name = merge.acct_name
        cop_url = merge.crm_url
        cop_addr = merge.address

        counter+=1
        puts
        puts "==================== #{counter} ===================="
        puts
        puts "--------- KEEP ---------"
        puts "#{keep_source}  #{keep_id}"
        puts keep_name
        puts keep_addr
        puts keep_url
        loc.update_attribute(:sts_duplicate, "Save")
        puts "--------- MERGE ---------"
        puts "#{cop_source}  #{cop_id}"
        puts cop_name
        puts cop_addr
        puts cop_url
        merge.update_attribute(:sts_duplicate, "Merge")

        puts

      end
    end

  end


  def sample_dup_finder
    locs = Location.where("acct_name = geo_acct_name").where("geo_full_addr = address").where("url = crm_url").where.not(crm_source: "Web")[0..0]

    counter=0
    locs.each do |loc|
      webs = Location.where(acct_name: loc.acct_name).where.not(crm_source: "CRM")

      saves = webs.where(address: loc.address).where(crm_url: loc.crm_url).where(sts_duplicate: nil)
      if web = saves.first
        counter +=1
        puts "#{counter}) Save"
        web.update_attribute(:sts_duplicate, "Save")
        saved = true
      end

      deletes = webs.where(coordinates: loc.coordinates).where(sts_duplicate: nil)
      deletes.each do |delete|
        counter +=1
        puts "#{counter}) Delete"

        delete.update_attribute(:sts_duplicate, "Delete") if saved
      end
    end

  end



  def non_matched_url_finder
    locs = Location.where("acct_name = geo_acct_name").where("geo_full_addr = address").where.not("url = crm_url").where.not(crm_source: "Cop")

    counter=0
    locs.each do |loc|
      geo_url = loc.url
      geo_act = loc.geo_acct_name
      geo_adr = loc.geo_full_addr

      crm_src = loc.crm_source
      crm_url = loc.crm_url
      crm_act = loc.acct_name
      crm_adr = loc.address

      puts
      counter+=1
      puts
      puts "============ #{counter}  ============"
      puts crm_src
      puts "------ CRM ------"
      puts crm_act
      puts crm_adr
      puts crm_url
      puts "------ GEO ------"
      puts geo_act
      puts geo_adr
      puts geo_url
      puts

      loc.update_attribute(:crm_url, loc.url)

    end


  end



  def missing_address
    locs = Location.where.not(crm_url: nil).where.not(crm_source: "Web").where(sts_duplicate: nil)

    counter=0
    locs.each do |loc|
      counter+=1
      print "#{counter}, "

      targets = Location.where.not(sfdc_id: loc.sfdc_id).where(acct_name: loc.acct_name).where(address: loc.address).where(crm_source: "Web")

      targets.each do |target|
        p "  =====  (X-Match) =======  "
        loc.update_attribute(:sts_duplicate, "O-Match")
        target.update_attribute(:sts_duplicate, "X-Match")
      end


    end
  end





  def unmatched_url
    # locations = Location.where("acct_name = geo_acct_name").where("address = geo_full_addr").where.not("url = crm_url")[0..100]

    locations = Location.where.not(url: nil).where.not(url: "").where("acct_name = geo_acct_name").where("address = geo_full_addr").where.not("url = crm_url")[0..0]


    locations.each do |location|


      # URLs
      loc_crm_url = location.crm_url
      loc_geo_url = location.url
      loc_url_arr = location.url_arr
      comb_url_arr = []
      comb_url_arr << loc_crm_url if loc_crm_url
      comb_url_arr << loc_geo_url if loc_geo_url

      comb_url_arr = comb_url_arr+loc_url_arr if loc_url_arr
      comb_url_arr.compact!
      comb_url_arr.uniq!
      comb_url_arr.sort!

      puts "==========================="
      puts "CRM: #{loc_crm_url}"
      puts "GEO: #{loc_geo_url}"
      puts
      puts "ARR:#{loc_url_arr}"
      puts
      puts "comb_url_arr"
      p comb_url_arr
      puts "---------------------"
      puts "=============================================="
      puts


      # location.update_attribute(:url_arr, comb_url_arr)

      location.update_attribute(:crm_url, location.url)


      # location.update_attribute(:sts_duplicate, "!URL")

    end

  end

  def crm_source_web_matcher
    locs = Location.where(crm_source: "Cop")
    counter=0
    locs.each do |loc|
      counter+=1
      print "Web:#{counter}, "
      loc.update_attributes(acct_name: loc.geo_acct_name, address: loc.geo_full_addr, crm_phone: loc.phone)
    end
  end


  def loc_core_dup_remover
    # locs = Location.where("acct_name = geo_acct_name").where("geo_full_addr = address").where.not(crm_source: "CRM")
    locs = Location.all

    save_counter=0
    locs.each do |loc|

      cores = Core.where(sfdc_id: loc.sfdc_id)
      cores.each do |core|
        save_counter+=1
        print "S:#{save_counter}, "
        core.update_attribute(:bds_status, "Save")
      end
    end

    removes = Core.where.not(bds_status: "Save")
    remove_counter=0
    removes.each do |remove|
      remove_counter+=1
      print "R:#{remove_counter}, "
      remove.update_attribute(:bds_status, "Remove")
    end

  end


  def dup_finder
    saves = Location.where("acct_name = geo_acct_name").where("geo_full_addr = address").where.not(crm_source: "Web")

    # saves = Location.where("url = crm_url")

    stamp=0
    counter=0

    saves.each do |save|
      stamp+=1
      print "#{stamp}, "

      # merges = Location.where.not(sfdc_id: save.sfdc_id).where(acct_name: save.acct_name).where(address: save.address).where.not(crm_source: "CRM")

      merges = Location.where.not(sfdc_id: save.sfdc_id).where(acct_name: save.acct_name).where(address: save.address).where.not(crm_source: "CRM")


      merges.each do |merge|

        # SAVE Variables
        sav_acct_name = save.acct_name
        sav_crm_source = save.crm_source
        sav_sts_dup = save.sts_duplicate
        sav_crm_addr = save.address

        # LOC Variables
        mrg_acct_name = merge.acct_name
        mrg_crm_source = merge.crm_source
        mrg_sts_dup = merge.sts_duplicate
        mrg_crm_addr = merge.address

        # URLs
        sav_crm_url = save.crm_url
        sav_geo_url = save.url
        mrg_crm_url = merge.crm_url
        mrg_geo_url = merge.url
        sav_url_arr = save.url_arr
        mrg_url_arr = merge.url_arr
        comb_url_arr = []
        comb_url_arr << mrg_crm_url if mrg_crm_url
        comb_url_arr << mrg_geo_url if mrg_geo_url
        comb_url_arr << sav_crm_url if sav_crm_url
        comb_url_arr << sav_geo_url if sav_geo_url

        comb_url_arr = comb_url_arr+sav_url_arr if sav_url_arr
        comb_url_arr = comb_url_arr+mrg_url_arr if mrg_url_arr
        comb_url_arr.compact!
        comb_url_arr.uniq!
        comb_url_arr.sort!

        # IDs
        sav_sfdc_id = save.sfdc_id
        sav_duplicate_arr = save.duplicate_arr
        mrg_sfdc_id = merge.sfdc_id
        mrg_duplicate_arr = merge.duplicate_arr
        comb_duplicate_arr = []
        comb_duplicate_arr << sav_sfdc_id
        comb_duplicate_arr << mrg_sfdc_id

        comb_duplicate_arr = comb_duplicate_arr+sav_duplicate_arr if sav_duplicate_arr
        comb_duplicate_arr = comb_duplicate_arr+mrg_duplicate_arr if mrg_duplicate_arr
        comb_duplicate_arr.compact!
        comb_duplicate_arr.uniq!
        comb_duplicate_arr.sort!

        # COP Franchises
        sav_cop_franch_arr = save.cop_franch_arr
        mrg_cop_franch_arr = merge.cop_franch_arr
        comb_cop_franch_arr = []

        mrg_cop_franch = merge.cop_franch
        if mrg_cop_franch
          mrg_cop_franch_arr = mrg_cop_franch.split(";") if mrg_cop_franch
          comb_cop_franch_arr = comb_cop_franch_arr+mrg_cop_franch_arr
        end

        comb_cop_franch_arr = sav_cop_franch_arr+comb_cop_franch_arr if sav_cop_franch_arr

        comb_cop_franch_arr = mrg_cop_franch_arr+comb_cop_franch_arr if mrg_cop_franch_arr
        comb_cop_franch_arr.compact!
        comb_cop_franch_arr.uniq!
        comb_cop_franch_arr.sort!


        save.update_attributes(sts_duplicate: "Save", url_arr: comb_url_arr, duplicate_arr: comb_duplicate_arr, cop_franch_arr: comb_cop_franch_arr)

        merge.update_attribute(:sts_duplicate, "Merge")


        # save_cores = Core.where(sfdc_id: merge.sfdc_id)
        # save_cores.each do |save_core|
        #     save_core.update_attribute(:bds_status, "none")
        # end

        # cores = Core.where(sfdc_id: merge.sfdc_id)
        # cores.each do |core|
        #     core.update_attribute(:bds_status, "Delete")
        # end


        counter+=1
        puts
        puts
        puts
        puts "===================== #{counter} ====================="
        puts sav_sfdc_id
        puts sav_acct_name
        puts sav_crm_source
        puts sav_sts_dup
        puts sav_crm_addr
        puts sav_crm_url
        puts "==========================="
        puts mrg_sfdc_id
        puts mrg_acct_name
        puts mrg_crm_source
        puts mrg_sts_dup
        puts mrg_crm_addr
        puts mrg_crm_url
        puts "==========================="
        puts "STOCK INFO"
        puts
        p sav_url_arr
        puts "---------------------"
        p mrg_url_arr
        puts "---------------------"
        p sav_duplicate_arr
        puts "---------------------"
        p mrg_duplicate_arr
        puts "---------------------"
        p sav_cop_franch_arr
        puts "---------------------"
        p mrg_cop_franch_arr
        puts
        puts "==========================="
        puts "comb_url_arr"
        p comb_url_arr
        puts "---------------------"
        puts "comb_duplicate_arr"
        p comb_duplicate_arr
        puts "---------------------"
        puts "comb_cop_franch_arr"
        p comb_cop_franch_arr
        puts "=============================================="
        puts
        puts
        puts

      end

    end
  end


  def sts_duplicate_destroyer
    locs = Location.where(sts_duplicate: "Delete")
    locs.each do |loc|

      cores = Core.where(sfdc_id: loc.sfdc_id)
      cores.each do |core|
        loc_sfdc_id = loc.sfdc_id
        loc_acct_name = loc.acct_name
        loc_crm_source = loc.crm_source
        loc_sts_dup = loc.sts_duplicate


        cor_sfdc_id = core.sfdc_id
        cor_acct_name = core.geo_acct_name
        cor_crm_source = core.alt_source

        puts
        puts "---------------------"
        puts

        puts loc_sts_dup

        puts cor_sfdc_id
        puts loc_sfdc_id

        puts cor_acct_name
        puts loc_acct_name

        puts cor_crm_source
        puts loc_crm_source

        core.update_attribute(:bds_status, "Delete")

      end


    end


  end





  def hybrid_address_matcher
    ## Combined with hybrid_address(full_address) below.
    ## Removes street name from full address.  If same, replaces CRM w/ GEO.

    locations = Location.where("address != geo_full_addr")
    counter = 1
    locations.each do |location|

      crm_full_addy = location.address unless location.address == nil
      geo_full_addy = location.geo_full_addr unless location.geo_full_addr == nil

      crm_hybrid = hybrid_address(crm_full_addy)
      geo_hybrid = hybrid_address(geo_full_addy)

      if crm_hybrid && geo_hybrid
        if crm_hybrid == geo_hybrid
          puts
          puts "=================== #{counter} ==================="
          puts
          puts "CRM: #{crm_hybrid}"
          puts "GEO: #{geo_hybrid}"
          puts
          puts "CRM: #{crm_full_addy}"
          puts "GEO: #{geo_full_addy}"
          puts
          puts

          counter +=1

          location.update_attribute(:address, geo_full_addy)
        end

      end


      #
      # if geo_hybrid == nil || geo_hybrid == ""

      # geo_full_addy_arr = geo_full_addy.split(",")
      # city_state = geo_full_addy_arr[0]
      # city_state_arr = city_state.split(" ")
      #
      # city = city_state_arr[0]
      # state = city_state_arr[1]
      # zip = geo_full_addy_arr[2]

      # state2 = state1 unless state1.length != 2
      # zip2 = zip1 unless zip1.length != 5

      # unless location.state_code == nil || location.state_code == ""
      #     zip = location.state_code unless location.state_code.length != 5
      #
      #     state = location.street[-2..-1].strip
      #     city = location.street.gsub(state, "").strip
      #
      #     state_upcase = state.upcase
      #
      #     if state == state_upcase && zip != nil && zip != ""
      #
      #         if crm_full_addy == nil || crm_full_addy == ""
      #             puts "------ #{counter} ------"
      #             puts "CRM Addy: #{crm_full_addy}"
      #             puts "GEO Addy: #{geo_full_addy}"
      #             new_full_addy = "#{city}, #{state}, #{zip}"
      #             puts "New Addy: #{new_full_addy}"
      #             counter +=1

      # location.update_attributes(street: nil, city: city, state: state, state_code: state, postal_code: zip, geo_full_addr: new_full_addy, address: new_full_addy)
      #     end
      # end

      # location.update_attributes(geo_full_addr: crm_full_addy, street: core.sfdc_street, city: core.sfdc_city, state_code: core.sfdc_state, postal_code: core.sfdc_zip)

      # end

      # end
      # end
    end

  end


  def hybrid_address(full_address)
    ## Combined with above method hybrid_address_matcher

    unless full_address == nil
      address_arr = full_address.split(",")
      unless address_arr[0] == nil
        street_full = address_arr[0]
        street_num = street_full.gsub(/[^0-9]/, "")
        # street_name = street_full.gsub(/[^A-Za-z]/, "")
        # consol_addy = full_address.tr('^A-Za-z0-9', '')
        # hybrid_addy = consol_addy.gsub(street_name, "").downcase!
      end
    end
  end



  def mix_match_addr_acct
    #matching address, but not acct name.
    locs = Location.where(crm_source: "CRM").where("address = geo_full_addr").where("acct_name != geo_acct_name")

    locs.each do |loc|
      loc.update_attribute(:sts_duplicate, "Mix-Match")

    end
  end




  ##################################
  #### DEPRECATED METHODS BELOW #####
  ## GEO-CODER METHODS BELOW ##

  # def start_geo(cores) ## From Button
  #     cores.each do |core|
  #         core.update_attributes(bds_status: "Queue Geo", geo_status: nil, geo_date: nil, latitude: nil, longitude: nil, coordinates: nil)
  #
  #         create_sfdc_loc(core)
  #     end
  # end
  #
  # def geo_starter(ids)  ## From 'Queue Geo' Batch Select
  #     Core.where(id: ids).each do |core|
  #         create_sfdc_loc(core)
  #     end
  # end
  #
  # ## Main Geo Coder Method Starts Here ##
  # def create_sfdc_loc(core)
  #
  #     full_address = core.full_address
  #
  #     if core.bds_status == "Queue Geo"
  #
  #         if full_address == "Missing Address"
  #             core.update_attributes(bds_status: "Geo Error", geo_status: "Geo Error", geo_date: Time.new)
  #             # return
  #         else
  #             location = Location.new(address: core.full_address, street: core.sfdc_street, city: core.sfdc_city, state_code: core.sfdc_state, postal_code: core.sfdc_zip, acct_name: core.sfdc_acct, group_name: core.sfdc_group, ult_group_name: core.sfdc_ult_grp, source: core.alt_source, sfdc_id: core.sfdc_id, tier: core.sfdc_tier, sales_person: core.sfdc_sales_person, acct_type: core.sfdc_type, location_status: "Geo Result", url: core.sfdc_url, root: core.sfdc_root, franchise: core.sfdc_franch_cons, franch_cat: core.sfdc_franch_cat, hierarchy: core.hierarchy)
  #
  #             if location.save
  #                 core.update_attributes(bds_status: 'Geo Result', geo_status: 'Geo Result', geo_date: Time.new, latitude: location.latitude, longitude: location.longitude, coordinates: "#{location.latitude}, #{location.longitude}")
  #
  #                 location.update_attribute(:coordinates, core.coordinates)
  #
  #                 staffs = Staffers.where(sfdc_id: location.sfdc_id)
  #                 staffs.each do |staff|
  #                     staff.update_attributes(coordinates: location.coordinates, full_address: location.full_address)
  #                 end
  #
  #                 #== Throttle ====
  #                 # sleep(0.02)
  #
  #             else
  #                 core.update_attributes(bds_status: "Geo Error", geo_status: "Geo Error", geo_date: Time.new)
  #             end  ## if location.save
  #         end ## if addr = "Missing Address"
  #     end  ## if core.bds_status == "Queue Geo"
  # end  ## create_sfdc_loc(core)
  #
  # def location_cleaner_btn
  #     cores = Core.where.not(temporary_id: nil)
  #     cores.each do |core|
  #         locations = Location.where(sfdc_id: core.temporary_id, source: "Dealer")
  #         locations.each do |location|
  #             location.update_attributes(sfdc_id: core.sfdc_id)
  #         end
  #     end
  # end
  #
  # def geo_update_migrate_btn
  #
  #     ## Updates Coordinates - Starts
  #     # locations = Location.all
  #     # locations.each do |location|
  #     #     puts "-----------------------"
  #     #     puts "Account: #{location.acct_name}"
  #     #     puts "Current Coords: #{location.coordinates}"
  #     #     location.update_attribute(:coordinates, "#{location.latitude}, #{location.longitude}")
  #     #     puts "Updated Coords: #{location.coordinates}"
  #     #     puts "-----------------------"
  #     # end  ## Updates Coordinates - Ends
  #
  #     ## Updates SFDC data to Locations - Starts
  #     # cores = Core.where.not(temporary_id: nil)
  #     # cores.each do |core|
  #     #     split_locations = Location.where(sfdc_id: core.sfdc_id, source: "Dealer")
  #     #     split_locations.each do |split_location|
  #     #         split_location.update_attributes(sfdc_id: core.sfdc_id, acct_name: core.sfdc_acct, group_name: core.sfdc_group, ult_group_name: core.sfdc_ult_grp, source: "Web", tier: core.sfdc_tier, sales_person: core.sfdc_sales_person, acct_type: core.sfdc_type, url: core.sfdc_url, root: core.sfdc_root, franchise: core.sfdc_franch_cons, franch_cat: core.sfdc_franch_cat, hierarchy: "None")
  #     #     end
  #     # end
  #
  #     # cores = Core.where(temporary_id: nil)
  #     # cores.each do |core|
  #     #
  #     #     sfdc_locations = Location.where(sfdc_id: core.sfdc_id, source: "CRM")
  #     #
  #     #     sfdc_locations.each do |sfdc_location|
  #     #         sfdc_location.update_attributes(acct_name: core.sfdc_acct, group_name: core.sfdc_group, ult_group_name: core.sfdc_ult_grp, tier: core.sfdc_tier, sales_person: core.sfdc_sales_person, acct_type: core.sfdc_type, url: core.sfdc_url, root: core.sfdc_root, franchise: core.sfdc_franch_cons, franch_cat: core.sfdc_franch_cat, hierarchy: "None")
  #     #     end  ## sfdc_locations.each do |sfdc_location| - Ends
  #     # end  ## cores.each do |core| - Ends
  #
  #     ## Delete from Locations if Core.where(latitude: nil)
  #     ## Core.where(latitude: nil).count / 23,932
  #     # cores = Core.where(latitude: nil)
  #     # counter = 0
  #     # cores.each do |core|
  #     #     locations = Location.where(sfdc_id: core.sfdc_id)
  #     #
  #     #     locations.each do |location|
  #     #         puts "----------------------"
  #     #         puts "Core SFDC ID: #{core.sfdc_id}"
  #     #         puts "Location SFDC ID: #{location.sfdc_id}"
  #     #         # sfdc_location.update_attributes(:location_status, "DELETE!")
  #     #         puts "Counter: #{counter}"
  #     #         counter +=1
  #     #     end  ## locations.each do |location| - Ends
  #     # end  ## cores.each do |core| - Ends
  #
  # end  ## geo_update_migrate_btn - Ends
  ##################################

  ##################################

end  ## Locations Class - Ends
