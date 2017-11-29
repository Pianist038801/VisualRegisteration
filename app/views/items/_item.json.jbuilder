json.extract! item, :id, :name, :supplier, :reference_number, :created_at, :updated_at
json.url item_url(item, format: :json)
