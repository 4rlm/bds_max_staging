module CSVTool
  extend ActiveSupport::Concern

  module ClassMethods
    # ===== Export CSV =====
    def to_csv
      CSV.generate do |csv|
        csv << column_names
        all.each do |obj|
          csv << obj.attributes.values_at(*column_names)
        end
      end
    end

    # ===== Import CSV =====
    def import_csv(file_name, model, sts_col=nil)
      cols =  model.column_names
      CSV.foreach(file_name.path, headers: true, skip_blanks: true) do |row|
        valid_hash = validate_hash(cols, row.to_hash)

        if obj = model.find_by(id: valid_hash["id"])
          # valid_hash[sts_col] = "Re-Imported" if sts_col
          model.record_timestamps = false
          obj.update_attributes(valid_hash)
          model.record_timestamps = true
        else
          valid_hash[sts_col] = "Imported" if sts_col
          model.create!(valid_hash)
        end
      end
    end

    def validate_hash(cols, hash)
      keys = hash.keys
      keys.each do |key|
        if !cols.include?(key)
          hash.delete(key)
        end
      end
      hash
    end

    # # ========= CSV column formatting =========
    # def capitalized(str)
    #     str.split.map(&:capitalize)*" " unless str.nil?
    # end
    #
    # def upcased(str)
    #     str.upcase unless str.nil?
    # end
    #
    # def downcased(str)
    #     str.downcase unless str.nil?
    # end
    # # ========= Ends CSV column formatting =========
  end
end


# # ========= CSV column formatting =========
# Capitalize columns
# row_hash[:bds_status] = capitalized(row_hash["bds_status"])
# row_hash[:sfdc_tier] = capitalized(row_hash["sfdc_tier"])
# row_hash[:sfdc_sales_person] = capitalized(row_hash["sfdc_sales_person"])
# row_hash[:sfdc_type] = capitalized(row_hash["sfdc_type"])
# row_hash[:sfdc_ult_grp] = capitalized(row_hash["sfdc_ult_grp"])
# row_hash[:sfdc_group] = capitalized(row_hash["sfdc_group"])
# row_hash[:sfdc_acct] = capitalized(row_hash["sfdc_acct"])
# row_hash[:sfdc_street] = capitalized(row_hash["sfdc_street"])
# row_hash[:sfdc_city] = capitalized(row_hash["sfdc_city"])
#
# Upcase column
# row_hash[:sfdc_state] = upcased(row_hash["sfdc_state"])
#
# Downcase columns
# row_hash[:sfdc_url] = downcased(row_hash["sfdc_url"])
# # ========= Ends CSV column formatting =========
