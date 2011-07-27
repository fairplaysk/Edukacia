Given /^the following "([^"]*)" factory_girl models:$/ do |factory_name, models|
  models.hashes.each do |model_hash|
    Factory(factory_name.to_sym, model_hash)
  end
end


