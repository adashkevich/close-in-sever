require "csv"
CSV.open("C:\\Users\\Andrei Dashkevich\\RubymineProjects\\close-in-sever\\jmeter\\variables\\locations.csv", "wb") do |csv|
  csv << ["location"]
  [27.44, 27.47, 27.50, 27.53, 27.56, 27.59, 27.62, 27.65, 27.68].each { |lat|
    [53.84, 53.87, 53.90, 53.93, 53.95].each { |lon|
      csv << [('%.2f' % lon) + ', ' + ('%.2f' % lat) + ', ' + ('%.2f' % (lon + 0.3)) + ', ' + ('%.2f' % (lat + 0.3))]
    }
  }
end