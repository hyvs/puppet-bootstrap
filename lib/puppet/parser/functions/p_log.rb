module Puppet::Parser::Functions
  newfunction(:p_log, :doc => <<-EOS
Logs an info using P normalization.

Prototype:

    p_log(msg)

Where msg is a string message.

For example:

  Given the following statements:

    p_log("The message")

  The result will be as follows:

    info:  The message
    EOS
  ) do |*arguments|
    #
    # This is to ensure that whenever we call this function from within
    # the Puppet manifest or alternatively form a template it will always
    # do the right thing ...
    #
    arguments = arguments.shift if arguments.first.is_a?(Array)

    raise Puppet::ParseError, "p_log(): Wrong number of arguments " +
      "given (#{arguments.size} for 1)" if arguments.size < 1

    msg = arguments.shift

    # This should cover all the generic numeric types present in Puppet ...
    unless msg.is_a?(String)
      raise Puppet::ParseError, 'p_log(): Requires a string ' +
        'type to work with'
    end

    Puppet::Parser::Functions.autoloader.loadall
    function_notice( [ msg ] )
  end
end

# vim: set ts=2 sw=2 et :
# encoding: utf-8
