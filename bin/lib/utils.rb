module Utils
  def self.GetCredentials(config = {})
    config = {
      prompt: nil,
      username: "",
      random_password: false,
      allow_random_password: false,
      allow_blank_password: false
    }.merge(config)
    print config[:prompt].strip
    print "\n"
    username = config[:username]
    if config[:random_password]
      password = SecureRandom.hex(16)
    else
      password = ""
    end

    while username.empty?
      print "Username: "
      STDOUT.flush
      username = STDIN.gets.chomp!
    end
    while password.empty?
      print "Password: "
      STDOUT.flush
      password = STDIN.gets.chomp!
      password = SecureRandom.hex(16) if config[:allow_random_password] && password.empty?
      break unless !config[:allow_blank_password] && !password.empty?
    end

    {username: username, password: password}
  end

  def self.YAMLload(filename)
    return nil unless File.exists? filename
    data = File.open(filename).read
    return YAML.load(data)
  end

  def self.YAMLdump(filename, data)
    yamldata = YAML.dump(data)
    file = File.open("config/database.yml", 'w')
    file.write(yamldata)
    file.close
  end

end
