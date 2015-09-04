Puppet::Type.type(:assert).provide(:ruby) do
  desc "The assert implementation."

  def exists?
    false
  end

  def assert_message
    value = resource[:message] || resource[:name]
    "Assert Failed: #{value}"
  end

  def create
    raise Puppet::Error, assert_message if not resource[:condition]
  end

  def destroy
    raise Puppet::Error, assert_message if not resource[:condition]
  end
end
