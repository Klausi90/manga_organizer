# frozen_string_literal: true

Dir[Rails.root.join('config/extensions/**/*.rb')].sort.each { |file| require file }
