CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

CarrierWave.configure do |config|
  config.asset_host = ActionController::Base.asset_host
end
