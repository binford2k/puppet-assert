Puppet::Type.newtype('assert') do
  desc "This type will simply assert that a condition is true. Useful for skipping classes that don't apply cleanly. Anything that requires a failing instance of this type will fail."

  ensurable do
    desc "If ensure is present, then this assert will take effect"

    newvalue(:present) do
      provider.create
    end
    newvalue(:absent) do
      provider.delete
    end

    defaultto :present
  end

  newparam(:name, :namevar => true) do
    desc "The name of the assert."
  end

  newparam(:message) do
    desc 'The message to be displayed when the assert fails'
  end

  newparam(:condition) do
    desc "The condition. Pass something 'truthy' to succeed and false to fail."

    # force the passed in value to a boolean value
    munge do |value|
      !! value
    end
  end

  newparam(:path) do
    desc "The assert will succeed if this path exists."
  end

  newparam(:file) do
    desc "The assert will succeed if this path exists and is a file."
  end

  newparam(:directory) do
    desc "The assert will succeed if this path exists and is a directory."
  end

  newparam(:command) do
    desc "The assert will succeed if this command executes successfully."
  end

  validate do
    count = 0
    [:condition, :path, :file, :directory, :command].each do |param|
      unless self.parameters[param].nil?
        count += 1
      end
    end

    # TODO: this doesn't catch when condition is doubled with another test
    #
    # can't check for 0, because a false "condition" might come in as undefined
    if count > 1
       fail Puppet::ParseError, "One only of condition, path, file, directory, command parameters are supported"
    end
  end

end
