class UnknownTemplate
  def initialize
    @manager = RtsManager.new
  end
  
  def meta_scraper(html, url, indexer)
    all_text = html.at_css('body').text

    # Get phones and title directly
    phones = @manager.rts_phones_finder(html) # Scrape all the phone numbers.
    title = html.at_css('head title') ? html.at_css('head title').text : nil

    state_zip_reg = Regexp.new("([A-Z]{2})[ ]?([0-9]{5})")
    if state_zip_match_data = state_zip_reg.match(all_text) #<MatchData "MI 48302" 1:"MI" 2:"48302">
      # Get state and zip
      state_zip = state_zip_match_data[0] # "MI 48302"
      state = state_zip_match_data[1] # "MI"
      zip = state_zip_match_data[2] # "48302"

      # Get combined street & city
      street_city_other = all_text.split(state_zip).first
      street_city_raw = street_city_other.split("\n")[-1] # "\t\t\t  \t1234 Nice St Plano, "
    else
      state, zip, street_city_raw = nil, nil, nil
    end

    result = {title: title, street_city_raw: street_city_raw, state: state, zip: zip, phones: phones}
    printer(result)
    update_indexer(result, indexer)
  end

  def update_indexer(result, indexer)
    indexer.update_attributes(indexer_status: "MS Result", acct_name: result[:title], rt_sts: "MS Result", raw_street: result[:street_city_raw], full_addr: "MS Result", street: "MS Result", city: "MS Result", state: result[:state], zip: result[:zip], phone: result[:phones][0], phones: result[:phones])
  end

  def printer(result)
    puts "\nTitle: #{result[:title].inspect}\nStreetCity: #{result[:street_city_raw].inspect}\nState: #{result[:state].inspect}\nZip: #{result[:zip].inspect}\nPhones: #{result[:phones].inspect}\n#{"-"*40}\n"
  end
end

# # Below Regex needs more logic. Not used yet.
# street = street_city_raw.match(/[\w.]+/).to_s # Grab only character and '.' except \t,\n,\r
# city = street_city_raw.split(street)[-1].match(/[\w.]+/).to_s
