require 'yaml'
require 'securerandom'
require 'pg'
require_relative 'utils'

PGCRYPTO = true

module Database
  def self.Configure
    config = Utils.YAMLload("config/database.yml.sample")
    if config == nil
      puts "No sample database config found - bailing"
      return
    end

    root_user = Utils.GetCredentials(
      prompt: "Please enter your root postgres username/password",
      allow_blank_password: true
    )
    dev_password = SecureRandom.hex(16)
    ["development", "test"].each do |environment|
      configureEnv(environment, config[environment], root_user, dev_password)
    end

    Utils.YAMLdump("config/database.yml", config)
  end

private
  def self.dbConnect(config)
    return PG::Connection.new(
      config[:host],
      config[:port],
      "", # options
      "", # tty
      config[:database], # database name
      config[:username],
      config[:password])
  end

  def self.configureEnv(environment, config, root_user, password = SecureRandom.hex(16))
    print "Setting up #{environment} environment\n"

    db_connection = dbConnect(
      host: config["host"], port: config["port"], database: "postgres",
      username: root_user[:username], password: root_user[:password]
    )

    username = config["username"]
    config["password"] = password
    results = db_connection.exec("SELECT rolname FROM pg_roles").values.flatten
    unless results.include?(username)
      db_connection.exec("CREATE ROLE #{username} LOGIN ENCRYPTED PASSWORD '#{password}' NOSUPERUSER INHERIT CREATEDB NOCREATEROLE NOREPLICATION")
    else
      print "Username already exists - Changing Password\n"
      db_connection.exec("ALTER USER #{username} WITH PASSWORD '#{password}'")
    end

    results = db_connection.exec("SELECT datname FROM pg_database").values.flatten
    unless results.include?(config["database"])
      db_connection.exec("CREATE DATABASE #{config["database"]} with OWNER = #{username} ENCODING 'UTF8' TABLESPACE = pg_default  CONNECTION LIMIT = -1")
    else
      print "Database already exists!\n"
    end

    db_connection = dbConnect(
      host: config["host"], port: config["port"], database: config["database"],
      username: root_user[:username], password: root_user[:password]
    )

    if PGCRYPTO
      db_connection.exec("CREATE EXTENSION IF NOT EXISTS pgcrypto")
    end
  end
end

