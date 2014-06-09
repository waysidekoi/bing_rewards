require 'json'
require 'faker'
require 'watir-webdriver'
require 'watir-scroll'

require 'bing/acct_sign_up'
require 'bing/refer_sign_up'
require 'bing/run'

module Bing
  def self.root
    File.expand_path "..", __FILE__
  end

  def self.assets
    File.join(root, "assets")
  end
end


