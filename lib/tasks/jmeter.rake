namespace :jmeter do

  desc 'Generates jmeter test plan'
  task :generate_plan, [:url, :count] do |t, args|
    require 'ruby-jmeter'

    generate_report *extract_options_from(args)
  end

  def extract_options_from(args)
    defaults = {
        url: 'http://localhost:3000',
        count: 10
    }

    options = defaults.merge(args)
    [options[:url], options[:count].to_i]
  end

  def generate_report(url, count)
    uri = URI(url)
    test do
      threads count: 10000 do
        defaults domain: uri.host, port: uri.port
        # cookies policy: 'rfc2109', clear_each_iteration: true

        header [
                   { name: 'Content-Type', value: 'application/json' },
                   { name: 'Authorization', value: 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNTQ0MTI0NTgzLCJleHAiOjE1NzU2NjA1ODMsImp0aSI6IjgwNzkyOGIxLWNlNDItNDliNS04MzBjLWI2YmU5Yjg0YzRiMCJ9.Ughn_8XW76em5jAqJo__ZOsBHZHuKGG56tOCcmMiXHU' },
               ]

        transaction 'View events' do
          visit name: 'View events', url: '/events?date=2018-10-07&area=ST_MakeEnvelope(114.3, 22.4, 114.1, 22.2)'
        end


        # transaction 'Sign in' do
        #   post name: 'signup', url: '/signup', raw_body: {user: new_user}.to_json
        #   post name: 'login', url: '/login', raw_body: {user: new_user.slice(:country_code, :phone, :password)}.to_json do
        #     # extract name: 'csrf-param', xpath: "//meta[@name='csrf-param']/@content", tolerant: true
        #   end
        #
        #   visit name: 'View events', url: '/events?date=2018-10-07&area=ST_MakeEnvelope(114.3, 22.4, 114.1, 22.2)'

          # http_header_manager name: 'X-CSRF-Token', value: '${csrf-token}'
          #
          #   submit name: '/users/sign_in', url: '/users/sign_in',
          #          fill_in: {
          #              '${csrf-param}' => '${csrf-token}',
          #              'user[email]' => email,
          #              'user[password]' => password,
          #          }
          #
          #   visit name: '/dashboard', url: '/dashboard' do
          #     extract name: 'menu-urls',
          #             xpath: "//div[contains(@class, 'article_body')]//ul//a/@href", tolerant: true
          #   end
          #
          #   visit name: 'Today', url: '${menu-urls_1}'
          #   visit name: 'Assigned', url: '${menu-urls_3}'
          #   visit name: 'Overview', url: '${menu-urls_5}'
        # end




        #
        # view_results_in_table
        # view_results_tree
        # graph_results
        # aggregate_graph
      end
    end.jmx file: 'tmp/jmeter.jmx'
    # end.run(path: 'C:\Program Files\apache-jmeter-5.0\bin')
  end
end
