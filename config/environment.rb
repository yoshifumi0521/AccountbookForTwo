# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
AccountbookForTwo::Application.initialize!

#koaraライブラリを使っていて、エラーででてたが、これで回避。
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE




