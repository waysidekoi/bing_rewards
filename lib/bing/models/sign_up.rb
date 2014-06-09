module Bing
  class Signup
    attr_reader :b

    def initialize
      @b = Watir::Browser.new :firefox
    end

    def create_account
      goto_signup
      fill_firstname(Faker::Name.first_name)
      fill_lastname(Faker::Name.last_name)
      fill_username(un = "#{Faker::Internet.user_name}#{rand(3102)}@hotmail.com")
      fill_password(pw = "#{Faker::Internet.user_name.slice(0,8)}#{rand(3102)}#{%q(!@#$%^&*).split(//).sample}")
      fill_zipcode(Faker::Address.zip_code)
      fill_birthmonth
      fill_birthday
      fill_birthyear
      fill_gender
      fill_phone
      fill_altemail("#{Faker::Internet.user_name}#{rand(3102)}@hotmail.com")

      b.checkbox(id:"iOptinEmail").clear
      @credentials = {user: un, pass: pw}
    end

    def add_to_file
      accts = JSON.parse(File.read(accts_file))
      accts << credentials
      File.open(accts_file, "w") { |f| f.write(accts.to_json) }
    end

    def goto_signup
      b.goto "https://signup.live.com/newuser.aspx"
    end

    def fill_firstname(name)
      b.text_field(id: "iFirstName").set(name)
    end

    def fill_lastname(name)
      b.text_field(id: "iLastName").set(name)
    end

    def fill_username(name)
      b.text_field(id: "imembernameeasi").set(name)
    end

    def fill_password(word)
      b.text_field(id: "iPwd").set(word)
      b.text_field(id: "iRetypePwd").set(word)
    end

    def fill_zipcode(zip)
      b.text_field(id: "iZipCode").set(zip)
    end

    def fill_birthmonth
      months = %w(January February March April May June)
      b.select_list(id: "iBirthMonth").select(months.shuffle.pop)
    end

    def fill_birthday
      dates = (1..31).to_a
      b.select_list(id: "iBirthDay").select(dates.shuffle.pop)
    end

    def fill_birthyear
      years = (1942..1986).to_a
      b.select_list(id: "iBirthYear").select(years.shuffle.pop)
    end

    def fill_gender
      genders = %w(Male Female)
      b.select_list(id: "iGender").select(genders.shuffle.pop)
    end

    def fill_phone
      phone = []
      10.times { phone.push(rand(0..9)) }
      b.text_field(id: "iPhone").set(phone.join)
    end

    def fill_altemail(email)
      b.text_field(id: "iAltEmail").set(email)
    end

    def fill_captcha
      b.text_field(id: "wlspispSolutionElement671a727d09a84c35b80fefdb718f7342").set(gets.chomp)
    end


  end
end

