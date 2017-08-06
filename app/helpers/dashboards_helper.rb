module DashboardsHelper
  def grap_data(db_name, col)
    dash = Dashboard.find_by(db_name: db_name, col_name: col)
    {col_alias: dash.col_alias, col_total: dash.col_total, item_list_total: dash.item_list_total}
  end
end
