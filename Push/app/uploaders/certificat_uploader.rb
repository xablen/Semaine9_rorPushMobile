# encoding: utf-8

class CertificatUploader < CarrierWave::Uploader::Base

  storage :file

  def store_dir
    "../certificats/#{model.id}"
  end

  def extension_white_list
     %w(pem)
 end

  def filename
     "#{mounted_as}.pem" if original_filename
   end

end
