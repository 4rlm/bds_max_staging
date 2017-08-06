class PageFinder
  def indexer_starter
    # a=0
    # z=100
    # a=100
    # z=200
    # a=200
    # z=300
    a=0
    z=-1

    # els = Indexer.where(template: "DealerFire").where(indexer_status: "Goose")[a...z]
    # els = Indexer.where(template: "Cobalt").where(indexer_status: "Goose")[a...z]
    # els = Indexer.where(template: "Cobalt").where(indexer_status: "TCP Error")[a...z]
    # els = Indexer.where(template: "Dealer Inspire").where(indexer_status: "Goose")[a...z]
    els = Indexer.where(indexer_status: "Goose")[a...z]  ##1,031




    # els = Indexer.where(template: "Dealer Inspire").where(clean_url: "http://www.haronjaguar.com")

    # indexers = Indexer.where(template: "Dealer Inspire").where(stf_status: "Valid Link")
    # indexers.each{|x| x.update_attribute(:indexer_status, "Page Result")}

    puts "count: #{els.count}\n\n\n"

    agent = Mechanize.new
    agent.follow_meta_refresh = true

    counter=0
    els.each do |el|
      @indexer = el

      counter+=1
      puts "\n\n#{'='*40}\n\n[#{a}...#{z}]  (#{counter}):  #{el.template}\n#{"-"*40}\n#{el.clean_url}\n\n"

      redirect_status = el.redirect_status
      if redirect_status == "Same" || redirect_status == "Updated"
        begin
          @url = el.clean_url
          begin
            page = agent.get(@url)
          rescue Mechanize::ResponseCodeError => e
            redirect_url = HTTParty.get(@url).request.last_uri.to_s
            page = agent.get(redirect_url)
          end
          page_finder(page, "staff")
          page_finder(page, "location")
        rescue
          error_msg = "Error: #{$!.message}"
          status = nil
          indexer_status = nil
          found = false

          indexer_terms = IndexerTerm.where(category: "url_redirect").where(sub_category: error_msg)
          indexer_terms.each do |term|
            if error_msg.include?(term.criteria_term)

              status = term.response_term
              found = true
            else
              status = error_msg
            end

            indexer_status = status == "TCP Error" ? status : "PF Error"
            break if found
          end # indexer_terms iteration ends

          indexer_status = "PF Error" unless found
          el.update_attributes(indexer_status: indexer_status, stf_status: status, staff_url: error_msg, loc_status: status, location_url: error_msg)
          el.update_attributes(indexer_status: indexer_status, stf_status: status, loc_status: status)
        end # rescue ends

        sleep(1)
      end
    end # Ends cores Loop
  end # Ends start_indexer(ids)

  def page_finder(page, mode)
    list = text_href_list(mode)
    text_list = list[:text_list]
    for text in text_list
      pages = page.links.select {|link| link.text.downcase.include?(text.downcase)}
      if pages.any?
        url_split_joiner(pages.first, mode)
        break
      end
    end

    if pages.empty? || pages.nil?
      href_list = list[:href_list]
      href_list.delete(/MeetOurDepartments/) # /MeetOurDepartments/ is the last href to search.
      for href in href_list
        if pages = page.link_with(:href => href)
          url_split_joiner(pages, mode)
          break
        end
      end
      if !pages
        # if pages = page.link_with(:href => /MeetOurDepartments/)
        #     url_split_joiner(pages, mode)
        add_indexer_row_with("PF None", "PF None", nil, nil, mode)
        # end
      end
    end
  end

  def url_split_joiner(pages, mode)
    url_s = @url.split('/')
    url_http = url_s[0]
    url_www = url_s[2]
    joined_url = validater(url_http, '//', url_www, pages.href)
    add_indexer_row_with("PF Result", pages.text.strip, pages.href, joined_url, mode)
  end

  def add_indexer_row_with(status, text, href, link, mode)
    # Clean the Data before updating database
    clean = record_cleaner(text, href, link)
    text, href, link = clean[:text], clean[:href], clean[:link]

    if mode == "location"
      printer(mode, status, text, link)
      @indexer.update_attributes(indexer_status: status, loc_status: status, location_url: link, location_text: text) if @indexer != nil
    elsif mode == "staff"
      printer(mode, status, text, link)
      @indexer.update_attributes(indexer_status: status, stf_status: status, staff_url: link, staff_text: text) if @indexer != nil
    end
  end

  def validater(url_http, dbl_slash, url_www, dirty_url)
    if dirty_url[0] != "/"
      dirty_url = "/" + dirty_url
    end

    if dirty_url.include?(url_http + dbl_slash)
      dirty_url
    else
      url_http + dbl_slash + url_www + dirty_url
    end
  end

  def to_regexp(arr)
    arr.map {|str| Regexp.new(str)}
  end

  def text_href_list(mode)
    if mode == "staff"
      text, href, term = "staff_text", "staff_href", @indexer.template
    elsif mode == "location"
      text, href, term = "loc_text", "loc_href", "general"
    end

    text_list = IndexerTerm.where(sub_category: text).where(criteria_term: term).map(&:response_term)
    href_list = to_regexp(IndexerTerm.where(sub_category: href).where(criteria_term: term).map(&:response_term))

    {text_list: text_list, href_list: href_list}
  end

  # ================== Helper ==================
  # Clean the Data before updating database
  def record_cleaner(text, href, link)
    # puts "\n\n==================================\n#{"="*15} DIRTY DATA #{"="*15}\ntext: #{text.inspect}\nhref: #{href.inspect}\nlink: #{link.inspect}\n#{"-"*40}\n\n"
    link = link_deslasher(link)
    {text: text, href: href, link: link}
  end

  def link_deslasher(link)
    link = (link && link[0] == "/") ? link[1..-1] : link
    link = (link && link[-1] == "/") ? link[0...-1] : link
  end

  def printer(mode, status, text, link)
    puts "\n\n==================================\n\nmode: #{mode.inspect}\n#{status.inspect}: #{text.inspect}\nlink: #{link.inspect}\ntext: #{text.inspect}\n#{"-"*40}\n\n"
  end


end
