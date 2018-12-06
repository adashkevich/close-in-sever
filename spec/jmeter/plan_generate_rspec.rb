require 'rails_helper'
# require 'spec_helper'
require 'ruby-jmeter'

RSpec.describe 'Generate plan for Jmeter', type: :request do

  context 'plans generation' do

    it 'generate 10.000 views of map plan' do
      test do
=begin
        threads count: 1 do
          header [{ name: 'Content-Type', value: 'application/json' }]
          transaction 'Sign in' do
            user = Fabricate.attributes_for :user
            post name: 'signup', url: '/signup', raw_body: { user: user }.to_json
            post name: 'login', url: '/login', raw_body: { user: user.slice(:country_code, :phone, :password) }.to_json do
              # extract name: 'csrf-param', xpath: "//meta[@name='csrf-param']/@content", tolerant: true
            end

          end
        end
=end

        threads count: 100 do
          uri = URI 'http://localhost:3000'
          defaults domain: uri.host, port: uri.port

          header [{ name: 'Authorization', value: 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNTQzMTcwMDMzLCJleHAiOjE1NDMyNTY0MzMsImp0aSI6ImU4ZjA4YWE3LTUwOWUtNDBiMi05YWE0LWE5NGY0NGVmYzgyMyJ9.UztmQQ1QklK7p0XZ_VV6DaBKfahmo_aknxCPD-SgsWg' }]
          visit name: 'View events', url: '/events?date=2018-10-07&area=ST_MakeEnvelope(114.3, 22.4, 114.1, 22.2)'
        end
      end.jmx file: 'tmp/jmeter.jmx'
    end
  end
end
