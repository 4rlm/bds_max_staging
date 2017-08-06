module ApplicationHelper
  # def ordered_list(arr)
  #     arr.uniq!
  #     if arr.include?(nil)
  #       # nil == "Blank"
  #       # arr.map{|blank| blank = "blank" }
  #         arr.delete(nil)
  #         arr.sort
  #     else
  #         arr.sort
  #     end
  # end

  def formatted_date_list(datetime_arr)
    datetime_arr.map {|datetime| datetime.strftime("%m/%d/%Y") if datetime}.uniq
  end

  def blank_remover(array)
    for i in 0...array.length
      if array[i] == ""
        array[i] = nil
      end
    end
    array.uniq
  end

  def percent_format(numerator, denominator)
    percent = (numerator / denominator.to_f) * 100
    number_to_percentage(percent, precision: 1)
  end
end

# ===== DATA =====
## franchise_list
# ['Acura', 'Alfa', 'Aston', 'Audi', 'Auto', 'Autogroup', 'Automall', 'Automotive', 'Autoplex', 'Autos', 'Autosales', 'Bentley', 'Benz', 'Bmw', 'Bugatti', 'Buick', 'Cadillac', 'Cars', 'Cdjr', 'Chev', 'Chevrolet', 'Chevy', 'Chrysler', 'Cjd', 'Corvette', 'Daewoo', 'Dealer', 'Dodge', 'Ferrari', 'Fiat', 'Ford', 'Gm', 'Gmc', 'Group', 'Highline', 'Honda', 'Hummer', 'Hyundai', 'Imports', 'Infiniti', 'Isuzu', 'Jaguar', 'Jeep', 'Kia', 'Lamborghini', 'Lexus', 'Lincoln', 'Lotus', 'Maserati', 'Mazda', 'Mb', 'Mclaren', 'Mercedes', 'Mercury', 'Mini', 'Mitsubishi', 'Motor', 'Motors', 'Nissan', 'Oldsmobile', 'Plymouth', 'Pontiac', 'Porsche', 'Ram', 'Range', 'Rolls', 'Rover', 'Royce', 'Saab', 'Saturn', 'Scion', 'Smart', 'Subaru', 'Superstore', 'Suzuki', 'Toyota', 'Trucks', 'Usedcars', 'Volkswagen', 'Volvo', 'Vw']

## template_list
# ["All Auto Network", "Autofunds", "Autofusion", "AutoJini", "Chapman.co", "Cobalt", "Dealer Direct", "DEALER eProcess", "Dealer Inspire", "Dealer Socket", "Dealer Spike", "Dealer.com", "DealerCar Search", "DealerFire", "DealerOn", "DealerPeak", "DealerTrend", "DLD Websites", "Dominion", "Drive Website", "Driving Force", "Driving Force", "eBizAutos", "FoxDealer", "fusionZone", "fusionZONE", "I/O COM", "Jazel Auto", "Motion Fuze", "Motorwebs", "Pixel Motion", "Remora", "Search Optics", "SERPCOM", "Slip Stream", "VinSolutions"]

## job_title_list
# ["Account Director", "Account Executive", "Accounts Payable", "Administrative", "AR/Billing", "Area Regional Manager", "Area VP", "Asst. Treasurer", "Attorney", "Business Development Manager", "Business Development Rep", "Buyer", "CEO", "CFO", "Chairman", "Controller", "COO", "CTO", "Data Management", "Dealer Principal", "Desk Manager", "Digital Marketing Manager", "Digital Marketing Rep", "Director", "Director of Alliances", "District Mgr", "Divisional Development Exec", "DMS Administrator", "Ecommerce Director", "Executive Manager", "F&I Manager", "First Look Internal Rep", "Fixed Operations Manager", "General Manager", "General Sales Manager", "Group Owner", "Internet Director", "Internet Manager", "IT", "Managing Partner", "Marketing Director", "Marketing Manager", "New Car Manager", "Office Manager", "Other", "Owner", "Photo Person/Photo Loader", "Platform/Regional Manager", "President", "Program Manager", "Purchasing Manager", "Regional Development Exec", "Regional Operations Director", "Resource", "Retail Operations Manager", "Sales Manager", "Salesperson", "Territory Sales Manager", "Used Car Director", "Used Car Manager", "Variable Operations Director", "Vice President"]

# state_list = ['AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'DC', 'FL', 'GA', 'GU', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY']
