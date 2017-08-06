module IndexersHelper

  def indexer_indicator(crm, geo)
    unless (crm == nil || geo == nil) || (crm == "" || geo == "")
      return crm != geo ? "ind-green" : ""
    end
  end
  
  def match_sts_ind(input)
    if input
      return input == "Matched" ? "ind-green" : ""
    end
  end

  def link_core_staffers(sfdc_ids)
    htmls = []
    sfdc_ids.each do |sfdc_id|
      core = Core.find_by(sfdc_id: sfdc_id)
      html = <<-HTML
      #{link_to sfdc_id, staffer_acct_contacts_path(core: core), :target => "_blank", class: 'scr-score-badge'}
      HTML
      htmls << html
    end
    htmls.join(' ').html_safe
  end

  # def link_core_staffers_with_url(indexer)
  #     clean_url = indexer.clean_url
  #     core = Core.find_by(sfdc_clean_url: clean_url)
  #     link_name = indexer.contact_status ? indexer.contact_status : "No contact_status"
  #
  #     link = <<-HTML
  #         #{link_to link_name, staffer_acct_contacts_path(indexer: indexer), :target => "_blank"}
  #     HTML
  #
  #     count = <<-HTML
  #         <span class="badge" data-toggle="tooltip" data-placement="top" title="staff #">#{indexer.web_staff_count}</span>
  #     HTML
  #     (link + " " + count).html_safe
  # end


  # def link_core_staffers_with_url(indexer)
  ## Replaced by newer version below.
  #     clean_url = indexer.clean_url
  #     core = Core.find_by(sfdc_clean_url: clean_url)
  #     link_name = indexer.contact_status ? indexer.contact_status : "No contact_status"
  #
  #     link = <<-HTML
  #         #{link_to indexer.web_staff_count, staffer_acct_contacts_path(indexer: indexer), :target => "_blank"}
  #     HTML
  #
  #     (link).html_safe
  # end


  def link_core_staffers_with_url(indexer)
    ## Replaces older version above.
    clean_url = indexer.clean_url
    core = Core.find_by(sfdc_clean_url: clean_url)
    if indexer.web_staff_count > 0
      link = <<-HTML
      #{link_to indexer.web_staff_count, staffer_acct_contacts_path(indexer: indexer), :target => "_blank"}
      HTML
      (link).html_safe
    else
      link = indexer.contact_status
    end
  end




end
