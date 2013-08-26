require 'net/ftp'

    task :cron => :environment do
      Dir.chdir("tmp") do
        Net::FTP.open("ftp.example.com") do |ftp|
          ftp.passive = true
          ftp.login('login', 'password')
          ftp.chdir("your_dir")
          ftp.get("your_file")
          # ... Load the files in the database here
        end
      end
    end