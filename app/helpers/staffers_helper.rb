module StaffersHelper
  def grap_right_core(staffer)
    src = staffer.cont_source
    if src == "CRM"
      Core.find_by(sfdc_id: staffer.sfdc_id)
    elsif src == "Web"
      Core.find_by(sfdc_clean_url: staffer.domain)
    end
  end

  def grap_right_staffers(staffer)
    src = staffer.cont_source
    if src == "CRM"
      Staffer.where(sfdc_id: staffer.sfdc_id)
    elsif src == "Web"
      Staffer.where(domain: staffer.domain)
    end
  end

end
