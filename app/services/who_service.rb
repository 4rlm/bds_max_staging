require 'rubygems'
require 'whois'
require 'csv'
require 'mechanize'
require 'open-uri'
require 'nokogiri'
require 'uri'
require 'socket'
require 'indexer_helper/rts/rts_manager'

class WhoService
  def who_starter
    a=0
    z=-1
    range = z-a

    indexers = Indexer.where.not(clean_url: nil).where(who_status: "WH Error").where.not(indexer_status: "Archived")[a..z]


    counter=0
    indexers.each do |indexer|
      counter+=1
      puts "\n#{'='*30}\n[#{a}...#{z}]  (#{counter}/#{range})"

      url = indexer.clean_url
      begin
        uri = URI(url)
        scheme = uri.scheme
        host = uri.host

        if host.include?("www.")
          host.gsub!("www.", "")
        end
        host_www = "www.#{host}"

        #Start Whois Section
        r = Whois.whois(host)
        if r.available?
          url_validation = "WH Invalid URL2"
          indexer.update_attributes(indexer_status: url_validation, who_status: url_validation)
        else
          url_validation = "WH Result"
          p = r.parser
          # rts_manager = RtsManager.new

          ## Registrant Contact Variables
          if r.registrant_contacts.present?
            @rts_manager = RtsManager.new
            registrant_contact_info = "Registrant Contact Info:>"
            registrant_id = r.registrant_contacts[0].id
            registrant_type =r.registrant_contacts[0].type
            registrant_name = r.registrant_contacts[0].name
            registrant_organization = r.registrant_contacts[0].organization
            registrant_address = r.registrant_contacts[0].address
            registrant_city = r.registrant_contacts[0].city
            registrant_zip = r.registrant_contacts[0].zip
            registrant_state = r.registrant_contacts[0].state

            registrant_phone1 = r.registrant_contacts[0].phone
            puts registrant_phone1
            registrant_phone = @rts_manager.phone_formatter(registrant_phone1)
            registrant_fax1 = r.registrant_contacts[0].fax
            puts registrant_fax1
            registrant_fax = @rts_manager.phone_formatter(registrant_fax1)

            registrant_email = r.registrant_contacts[0].email
            registrant_url = r.registrant_contacts[0].url

            puts "------------- #{registrant_contact_info} -------------"
            puts "ID: #{registrant_id}"
            puts "Type: #{registrant_type}"
            puts "Name: #{registrant_name}"
            puts "Organization: #{registrant_organization}"
            puts "Address: #{registrant_address}"
            puts "City: #{registrant_city}"
            puts "Zip: #{registrant_zip}"
            puts "State: #{registrant_state}"
            puts "Phone: #{registrant_phone}"
            puts "Fax: #{registrant_fax}"
            puts "Email: #{registrant_email}"
            puts "URL: #{registrant_url}"
            puts ""
          end # Ends Registrant Contacts


          ## Tech Data Variables
          tech_data_info = "Tech Data Info:>"
          # domain = p.domain
          domain = url
          domain_id = r.domain_id
          ip = IPSocket::getaddress(host_www)
          server1 = r.nameservers[0]
          server2 = r.nameservers[1]
          registrar_url = p.registrar.url
          registrar_id = p.registrar.id

          puts "------------- #{tech_data_info} -------------"
          puts "Domain: #{domain}"
          puts "Domain ID: #{domain_id}"
          puts "IP: #{ip}"
          puts "Server 1: #{server1}"
          puts "Server 2: #{server2}"
          puts "Registrar URL: #{registrar_url}"
          puts "Registrar URL: #{registrar_id}"
          puts ""

          # who_status = "WhoIs Result"
          # url_status = "WhoIs Result"

          who_addr_pin = acct_pin_gen(registrant_address, registrant_zip)

          puts "\n\n\n============================="
          puts "who_addr_pin: #{who_addr_pin}"
          puts "\n\n\n============================="

          puts "\n\nBOOLEAN  who: #{Who.where(domain: indexer.clean_url).map(&:id)}\n\n"
          # binding.pry
          Who.find_or_create_by(
          domain: indexer.clean_url
          ) do |who|
            who.who_status = url_validation
            who.url_status = url_validation
            who.domain = domain
            who.domain_id = domain_id
            who.ip = ip
            who.server1 = server1
            who.server2 = server2
            who.registrar_url = registrar_url
            who.registrar_id = registrar_id
            who.who_addr_pin = who_addr_pin
            who.registrant_name = registrant_name
            who.registrant_organization = registrant_organization
            who.registrant_address = registrant_address
            who.registrant_city = registrant_city
            who.registrant_zip = registrant_zip
            who.registrant_state = registrant_state
            who.registrant_phone = registrant_phone
            who.registrant_fax = registrant_fax
            who.registrant_email = registrant_email
            who.registrant_url = registrant_url
          end

          indexer.update_attributes(indexer_status: url_validation, who_status: url_validation)

        end # End of if r.available?

        # ------ Final Results Summary for both Valid & Invalid URLs -------
        puts "URL: #{url}"
        puts "Status: #{url_validation}"
        puts "Scheme: #{scheme} & Host: #{host}"
        puts "====== Completed Whois Search ======"
        puts ""

        delay_time = rand(5)
        sleep(delay_time)
      rescue
        indexer.update_attributes(indexer_status: "WH Error2", who_status: "WH Error2")
      end # end begin
    end # end indexers iteration
  end # end who_starter


  def acct_pin_gen(street, zip)
    if street && zip
      street_parts = street.split(" ")
      street_num = street_parts[0]
      street_num = street_num.tr('^0-9', '')
      new_zip = zip.strip
      new_zip = zip[0..4]
      acct_pin = "z#{new_zip}-s#{street_num}"
    end
  end
end # WhoService class Ends ---
