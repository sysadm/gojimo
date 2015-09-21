class ApiStore < ActiveRecord::Base

  BASE_API_URL = 'https://api.gojimo.net'

  class << self
    def link_expired?(link)
      uri = URI(BASE_API_URL + link.to_s)
      begin
        Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
          request = Net::HTTP::Head.new uri
          response = http.request request
          @last_modified = response['Last-Modified']
        end
      rescue => e
        logger.fatal "Can't connect to API server 'cause: #{e.message}"
        return false
      end
      saved_last_modified = ApiStore.where(link: link).pluck(:last_modified).first
      @last_modified == saved_last_modified ? false : true
    end

    def request(link)
      if link_expired? link
        uri = URI(BASE_API_URL + link)
        Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
          request = Net::HTTP::Get.new uri
          @response = http.request request
        end
        @item = ApiStore.find_or_create_by(link: link)
        @item.update_attributes(last_modified: @response['Last-Modified'], raw: @response.body)
        @item
      end
    end

    def get_subjects_if_necessary
      new_index = request "/api/v4/subjects"
      if new_index
        data = JSON.load(new_index.raw)
        data.each do |s|
          subject = Subject.find_or_create_by(system_id: s['id'])
          subject.update_attributes(
              name: s['name'],
              link: s['link'],
              icon: s['icon'],
              colour: s['colour']
          )
        end
      end
    end

    def get_countries_if_necessary
      new_index = request "/api/v4/countries"
      if new_index
        data = JSON.load(new_index.raw)
        data.each do |c|
          country = Country.find_or_create_by(code: c['code'])
          country.update_attributes(
              name: c['name'],
              link: c['link']
          )
        end
      end
    end

    def get_qualifications_if_necessary
      new_index = request "/api/v4/qualifications"
      if new_index
        data = JSON.load(new_index.raw)
        data.each do |q|
          qualification = Qualification.find_or_create_by(system_id: q['id'])
          q['country'].nil? ? country_id = nil : country_id = Country.find_by_code(q['country']['code']).id
          qualification.update_attributes(
              name: q['name'],
              link: q['link'],
              country_id: country_id
          )
          if q['subjects'].count > 0
            q['subjects'].each do |s|
              qualification.subjects << Subject.find_by(system_id: s['id'])
            end
            qualification.update_attribute(:subjects_count, qualification.subjects.count)
          end
        end
      end
    end

    # methods below was created for development reason
    def get_all
      get_countries_if_necessary
      get_subjects_if_necessary
      get_qualifications_if_necessary
    end

    def remove_all
      Qualification.destroy_all
      Country.destroy_all
      Subject.destroy_all
      ApiStore.destroy_all
    end
  end
end
