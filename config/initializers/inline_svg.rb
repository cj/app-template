# frozen_string_literal: true

InlineSvg.configure do |config|
  config.asset_file = InlineSvg::CachedAssetFile.new(
    paths: [
      "#{Rails.root}/app/javascript/assets",
    ],
    filters: /\.svg/,
  )
end
