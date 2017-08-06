class DashboardService

  def mega_dash
    dash(Core)
    list_getter(Core, [:alt_source, :bds_status, :staff_pf_sts, :loc_pf_sts, :staffer_sts, :sfdc_type, :sfdc_tier, :sfdc_sales_person, :sfdc_state, :sfdc_franch_cons, :sfdc_franch_cat, :template, :acct_merge_sts, :acct_match_sts, :alt_state, :match_score, :ph_match_sts, :pin_match_sts, :redirect_sts, :url_match_sts, :who_sts, :alt_template])
    puts "\n\n#{'-'*50}\n\n"
    dash(InHostPo)
    list_getter(InHostPo, [:consolidated_term, :category])
    puts "\n\n#{'-'*50}\n\n"
    dash(Indexer)
    list_getter(Indexer, [:redirect_status, :indexer_status, :who_status, :rt_sts, :cont_sts, :loc_status, :stf_status, :contact_status, :template, :state])
    puts "\n\n#{'-'*50}\n\n"
    dash(Location)
    list_getter(Location, [:location_status, :sts_duplicate, :sts_geo_crm, :sts_url, :sts_acct, :sts_addr, :sts_ph, :crm_source, :tier, :sales_person, :acct_type, :url_sts, :acct_sts, :addr_sts, :ph_sts])
    puts "\n\n#{'-'*50}\n\n"
    dash(Staffer)
    list_getter(Staffer, [:staffer_status, :cont_source, :sfdc_type, :sfdc_tier, :sfdc_sales_person, :cont_status, :job])
    puts "\n\n#{'-'*50}\n\n"
    dash(Who)
    list_getter(Who, [:who_status, :url_status])
  end

  def dash(model)
    cols = model.column_names
    model_name = model.to_s
    existings = Dashboard.where(db_name: model_name).map(&:col_name)

    old_cols_remover(cols, model_name, existings)
    new_cols_creater(cols, model_name, existings)
    col_counter(model, cols, model_name)
  end

  # Helper method for `dash`
  def col_counter(model, cols, model_name)
    cols.delete("created_at")
    cols.delete("updated_at")

    puts "#{'='*30} #{model_name} #{'='*30}"
    cols.each do |col|
      records = model.all.map(&col.to_sym)
      records.delete_if {|el| el.blank?}
      total = records.count
      uniqs = records.uniq.count
      dash = Dashboard.find_by(db_name: model_name, col_name: col)

      puts "[#{col}] total: #{total}, uniqs: #{uniqs}"
      dash.update_attributes(col_total: total, item_list_total: uniqs) if dash
    end
  end

  def list_getter(model, cols) # list_getter(Staffer, [:staffer_status, :cont_status])
    puts "#{'='*30} Item List #{'='*30}"
    cols.each do |col|
      item_list = model.all.map(&col).uniq

      if item_list.any?
        list_hash = {}
        item_list.each do |val|
          list_hash[val] = model.where("#{col}": val).count
        end

        dash = Dashboard.find_by(db_name: model.to_s, col_name: col)
        puts "#{col}: #{item_list.inspect}"
        dash.update_attributes(item_list: item_list, obj_list: list_hash) if dash
      end

    end
  end

  def render_summarize_data(db_name, cols)
    result = [
      {
        name: "col_total",
        data: []
        },{
          name: "item_list_total",
          data: []
        }
      ]

      cols.each do |col|
        dash = Dashboard.find_by(db_name: db_name, col_name: col)
        if dash
          result[0][:data] << [dash.col_alias, dash.col_total]
          result[1][:data] << [dash.col_alias, dash.item_list_total]
        end
      end

      result # return: an array
    end

    # This method is used "one time" when populating hash column with item_list.
    def item_list_to_hash
      dashboards = Dashboard.all

      dashboards.each do |dashboard|
        model = Object.const_get(dashboard.db_name)
        col_name = dashboard.col_name
        item_list = dashboard.item_list

        if item_list.any?
          list = {}
          item_list.each do |val|
            list[val] = model.where("#{col_name}": val).count
          end
          dashboard.update_attribute(:obj_list, list)
        end
      end
    end

    def new_cols_creater(cols, model_name, existings)
      cols.delete("id")
      cols.delete("created_at")
      cols.delete("updated_at")
      model_alias = Dashboard.find_by(db_name: model_name).db_alias

      new_cols = cols.reject { |col| existings.include?(col) }

      new_cols.each do |col|
        values = {db_name: model_name, db_alias: model_alias, col_name: col, col_alias: col}
        p values
        Dashboard.create(values)
      end
    end

    def old_cols_remover(cols, model_name, existings)
      to_delete = existings.reject { |col| cols.include?(col) }

      to_delete.each do |col|
        dashboard = Dashboard.find_by(db_name: model_name, col_name: col)
        p dashboard
        dashboard.destroy
      end
    end

  end # DashboardService class Ends ---
