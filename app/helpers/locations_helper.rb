module LocationsHelper
  def add_http(url)
    return url.include?("http") ? url : "http://#{url}"
  end

  def geo_indicator(crm, geo)
    unless (crm == nil || geo == nil) || (crm == "" || geo == "")
      return crm == geo ? "bg-light-green" : ""
    end
  end

  def get_other_sfdc_ids(location)
    ids = location.coord_id_arr
    ids.delete(location.sfdc_id)
    ids
  end
end
