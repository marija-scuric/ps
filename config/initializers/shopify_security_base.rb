# typed: false
# frozen_string_literal: true

ShopifySecurityBase.configure do |config|
  config.opt_out = [:idor_prevention]
end
