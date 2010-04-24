# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sportbookpage_session',
  :secret      => '1e79bf9e01e3f47591ff520fa594519fcb4d863ead0109e369997cc89d6ca62363563c5b3dfe00330b585c667a4f1c5605e87a4c0885900b446e75162beef3e9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
#ActionController::Base.session_store = :active_record_store


  ActiveRecord::Base.connection.execute("SET sql_big_selects=1")
