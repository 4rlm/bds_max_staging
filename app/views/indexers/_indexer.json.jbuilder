json.extract! indexer, :id, :raw_url, :redirect_status, :clean_url, :indexer_status, :staff_url, :staff_text, :location_url, :location_text, :template, :crm_id_arr, :created_at, :updated_at
json.url indexer_url(indexer, format: :json)
