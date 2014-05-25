module Puppet::Parser::Functions
  newfunction(:any2int, :type => :rvalue, :doc => <<-EOS
Converts a value to integer.

Prototype:

    any2int(value)

Where value is a value.

For example:

  Given the following statements:

    notice any2int("12")

  The result will be as follows:

    notice: 12
    EOS
  ) do |*arguments|
    #
    # This is to ensure that whenever we call this function from within
    # the Puppet manifest or alternatively form a template it will always
    # do the right thing ...
    #
    arguments = arguments.shift if arguments.first.is_a?(Array)

    raise Puppet::ParseError, "any2int(): Wrong number of arguments " +
      "given (#{arguments.size} for 1)" if arguments.size < 1

    v = arguments.shift

    return v.to_i
  end
end

# vim: set ts=2 sw=2 et :
# encoding: utf-8
