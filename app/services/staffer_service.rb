require 'mechanize'
require 'nokogiri'
require 'open-uri'
require 'staffer_helper/cs_helper'
require 'staffer_helper/dealer_eprocess_cs'
require 'staffer_helper/dealerfire_cs'
require 'staffer_helper/dealer_inspire_cs'
require 'staffer_helper/cobalt_cs'
require 'staffer_helper/dealeron_cs'
require 'staffer_helper/dealer_direct_cs'
require 'staffer_helper/dealer_com_cs'
require 'indexer_helper/rts/rts_manager'

class StafferService

  def initialize
    @start_at_id_num = 0
    # @tcp_error_count = 0
    # @url_status = false
  end
  ### !! REPLACE SCRAPE DATE WITH THIS IN QUERY AFTER ALL HAVE DATES. ###
  # Indexer.where.not('scrape_date <= ?', Date.today - 1.week).count
  # Staffer.where.not('updated_at <= ?', Date.today - 1.day).count
  # indexer_status: cs_error_code
  ###################################
  def cs_starter
    # make_batched_queries
    make_standard_queries
  end

  def make_standard_queries
    indexers = Indexer.where(indexer_status: 'invalid staff_url', scrape_date: nil).where("web_staff_count > 0") #=> 10,582

    # Indexer.where("indexer_status = 'CS Error'").where("web_staff_count > 0").count #=> 51
    standard_iterator(indexers)
  end

  def make_batched_queries
    batch_size = 1
    start_at_id_num = 0

    # batched_by_tcp_error = Indexer.where.not(staff_url: nil).where(contact_status: 'TCP Error').find_in_batches(start: start_at_id_num, batch_size: batch_size)
    # batch_iterator(batched_by_tcp_error)

    # batched_by_scrape_date = Indexer.where.not(staff_url: nil).where(scrape_date: nil).find_in_batches(start: start_at_id_num, batch_size: batch_size)

    batch_iterator(batched_by_scrape_date)
  end

  def batch_iterator(batch_of_batches)
    batch_of_batches.each { |indexers| standard_iterator(indexers) }
  end

  def standard_iterator(indexers)
    indexers.each do |indexer|
      cs_data_getter(indexer)
    end
  end

  def view_indexer_current_db_info(indexer)
    puts "\n=== Current DB Info ===\n"
    puts "indexer_status: #{indexer.indexer_status}"
    puts "staff_url: #{indexer.template}"
    puts "staff_url: #{indexer.staff_url}"
    puts "web_staff_count: #{indexer.web_staff_count}"
    puts "scrape_date: #{indexer.scrape_date}"
    puts "#{"="*30}\n\n"
  end

  def ping_url
    pingable_urls = %w(
    http://speedtest.hafslundtelekom.net/
    http://www.whatsmyip.org/
    https://fast.com/
    http://speedtest.xfinity.com/
    https://www.iplocation.net/
    https://www.wikipedia.org/
    http://www.bandwidthplace.com/
    http://www.speedinternet.co/
    https://www.google.com/)
    pingable_urls.sample
  end

  def test_internet_connection
    sample_url = ping_url
    begin
      result = true if open(ping_url)
    rescue
      result = false
    end

    puts "Internet Connection: #{result} via #{sample_url} ==="
    result
  end

  def url_exist?(url_string)
    begin
      url = URI.parse(url_string)
      req = Net::HTTP.new(url.host, url.port)
      req.use_ssl = (url.scheme == 'https')
      res = req.request_head(url || '/')
      if res.kind_of?(Net::HTTPRedirection)
        url_exist?(res['location']) # Go after any redirect and make sure you can access the redirected URL
      else
        res.code[0] != "4" #false if http code starts with 4 - error on your side.
      end
    rescue
      # puts $!.message
      false #false if can't find the server
    end
  end

  def validate_url(url_string)
    if url_exist?(url_string)
      puts "=== GOOD URL ===\nURL: #{url_string}"
    else
      if test_internet_connection
        puts "=== BAD URL ===\nURL: #{url_string}"
      else
        connection = false
        ping_attempt_count = 1

        while !connection
          sleep_time = 5 * ping_attempt_count
          puts "\nNO INTERNET CONNECTION\nCONNECTION TEST ATTEMPTS: #{ping_attempt_count}\nTRY AGAIN IN: #{sleep_time} SECONDS\n#{"="*30}\n\n"
          sleep(sleep_time)
          connection = test_internet_connection
          ping_attempt_count += 1
          break if connection
        end
        validate_url(url_string)
      end
    end
    # sleep(0.015)
  end

  def start_mechanize(url_string)
    begin
      @agent = Mechanize.new
      html = @agent.get(url_string)
    rescue
      if validate_url(url_string)
        start_mechanize(url_string)
      end
    end
  end

  def cs_data_getter(indexer)
    view_indexer_current_db_info(indexer)
    template = indexer.template
    url = indexer.staff_url

    if start_mechanize(url)
      puts "=== GOOD URL ===\nURL: #{url}"
      html = start_mechanize(url)
    else
      puts "ResponseCodeError occurred"
      indexer.update_attributes(scrape_date: DateTime.now, indexer_status: "invalid staff_url", contact_status: "invalid staff_url")
      return
    end

    begin
      case template
      when "Dealer.com"
        DealerComCs.new.contact_scraper(html, url, indexer)
      when "Cobalt"
        CobaltCs.new.contact_scraper(html, url, indexer)
      when "DealerOn"
        DealeronCs.new.contact_scraper(html, url, indexer)
      when "Dealer Direct"
        DealerDirectCs.new.contact_scraper(html, url, indexer)
      when "Dealer Inspire"
        DealerInspireCs.new.contact_scraper(html, url, indexer)
      when "DealerFire"
        DealerfireCs.new.contact_scraper(html, url, indexer)
      when "DEALER eProcess"
        DealerEprocessCs.new.contact_scraper(html, url, indexer)
      else
        StandardScraperCs.new.contact_scraper(html, url, indexer)
      end

    rescue
      error = $!.message
      error_msg = "CS Error: #{error}"
      if error_msg.include?("connection refused")
        cs_error_code = "Connection Error"
      elsif error_msg.include?("undefined method")
        cs_error_code = "Method Error"
      elsif error_msg.include?("404 (Net::HTTPNotFound)")
        cs_error_code = "404 Error"
      elsif error_msg.include?("TCP connection")
        cs_error_code = "TCP Error"
      else
        cs_error_code = "CS Error"
      end

      puts "\n\n==== Error: #{cs_error_code} ====\n\n"

      indexer.update_attributes(scrape_date: DateTime.now, indexer_status: cs_error_code, contact_status: cs_error_code)

    end ## rescue ends
  end

  ################################################################

  # When first name is "["Jack", "McCarthy", "Business Manage.....", it cleans to "Jack".
  def fname_cleaner
    urls = Indexer.where(template: "Dealer.com").map(&:clean_url).uniq
    staffers = Staffer.where(domain: urls)

    staffers.each do |staffer|
      fname = staffer.fname
      lname = staffer.lname
      fullname = staffer.fullname

      if fname && lname && fullname
        merged_name = fname + " " + lname

        if fullname != merged_name
          puts "\n\nOLD First Name: #{fname}\nNEW First Name: #{fullname.split(" ")[0]}\n\n"
          staffer.update_attributes(fname: fullname.split(" ")[0])
        end
      end
    end
  end

  def crm_staff_counter
    cores = Core.all

    num = 0
    cores.each do |core|
      num += 1
      staff_count = Staffer.where(sfdc_id: core.sfdc_id).count
      puts ">>>>>>num:  #{num}, staff_count: #{staff_count}"
      core.update_attribute(:crm_staff_count, staff_count)
    end
  end


end
