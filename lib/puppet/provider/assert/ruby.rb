Puppet::Type.type(:assert).provide(:ruby) do
  desc "The assert implementation."

  def exists?
    if resource[:path]
      File.exist? resource[:path]

    elsif resource[:file]
      File.file? resource[:file]

    elsif resource[:symlink]
      File.symlink? resource[:symlink]

    elsif resource[:directory]
      File.directory? resource[:directory]

    elsif resource[:command]
      system(resource[:command])

    # must be last, because we cannot validate false/undef conditions
    else
      resource[:condition]
    end
  end

  def assert_message
    value = resource[:message] || resource[:name]
    "Assert Failed: #{value}"
  end

  def create
    raise Puppet::Error, assert_message
  end

  def destroy
    raise Puppet::Error, assert_message
  end

end
