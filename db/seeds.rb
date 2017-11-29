unless PayType.any?
  [
    "Overtime",
    "Vacation"
  ].each do |description|
    PayType.create(description: description)
  end
end