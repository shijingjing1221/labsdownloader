# coding: utf-8
class LabsDownloader
  require 'zip'
  require 'json'
  
  def self.download_script(base, content, file_name = 'script.sh')
    # ^ provides some sane default for file_name... let user override

    # send the front end content down to the end user as a text file
    base.send_data content, type: "application/text", filename: file_name
  end


  def self.download_zip(base, zip_files, zip_name = 'file.zip')
    # ^ provides some sane default for zip_name... let user override

    # Use TempFile block so we dont have to write ensure .close() code
    Tempfile.open("tempZipFile-#{Random.rand(10...100000)}-#{Time.now.to_f}") do |temp_file|

      # build the zip
      Zip::OutputStream.open(temp_file.path) do |z|
        zip_files.each do | index, file |
          z.put_next_entry(file['file_name'])
          content = file['content']
          z.print content
        end
      end

      # send the zip
      base.send_file temp_file.path, :type => 'application/zip',
                :disposition => 'attachment',
                :filename => zip_name
    end
  end
end
