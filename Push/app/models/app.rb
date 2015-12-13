class App < ActiveRecord::Base

	has_many :devices
	has_many :feeds

	validates :name, presence: true, length: { minimum: 2}
	mount_uploader :certificat_ios, CertificatUploader

	before_create do
	  require "securerandom"
      self.token = SecureRandom.hex
	end
end
