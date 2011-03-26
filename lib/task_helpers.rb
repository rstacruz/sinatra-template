# These are helpers available in Rake tasks.

# Shows the status of a record.
# @example
#
#   record_status :add, Deal[1]
#   record_status :delete, Deal[1]
#
def record_status(what, record)
  col, prefix = if what == :update
      [36, "==="]
    elsif what == :add
      [32, "+++"]
    elsif what == :delete
      [31, "---"]
    else
      [0, what]
    end

  if record.nil?
    message = "nil"
  else
    id = "%-11s" % "[#{record.class.name} ##{record.id}]"
    id = color(id, col)

    message = record.respond_to?(:inspect_name) ? record.inspect_name : record.to_s
    message = "#{id} #{message}"
    message.gsub! "\n", "\n"+(" "*12)
  end

  status message, prefix, col
end

# Colors a string.
def color(str, col)
  "\033[0;#{col}m#{str}\033[0;m"
end

# Logs a message.
def status(message, prefix='*', col=36)
  puts "%-5s  %s" % [ color(prefix, col), message ]
end

# Logs an error.
def err(message)
  if message.is_a?(StandardError)
    err message.message
    message.backtrace.each { |line| err "  " + line }
    return
  end

  status message, "ERR", 31
end
