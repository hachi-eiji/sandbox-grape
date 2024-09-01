# frozen_string_literal: true

dummy = Rails.root.join("lib/dummy")
# このディレクトリはload pathに含めないと中のファイルのrequireが解決できない
$LOAD_PATH.unshift(dummy.to_s)
# 各ファイルを個別でrequireする
Dir["#{dummy}/**/*.rb"].each do |file|
  require file
end
