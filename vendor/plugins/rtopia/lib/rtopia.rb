require 'uri'
require 'cgi'

module Rtopia
  VERSION = "0.2.3"

  # In order to be able to do `Rtopia::R`, Rtopia needs to extend itself
  extend self

  # @example
  #
  #    R(:items) # => /items
  #    
  #    @person = Person.new # has a to_param of john-doe
  #    R(@person) # => '/john-doe'
  #    R(@person, :posts) # => '/john-doe/posts'
  #    R(@person, :posts, :replied) # => '/john-doe/posts/replied'
  #
  #    @entry = Entry.create # has an id of 1001 for example and Ruby1.9
  #    R(@entry) # => '/1001'
  #    R(:entry, @entry) # => '/entry/1001'
  #   
  #    R(:search, :q => 'Ruby', :page => 1) => '/search?q=Ruby&page=1'
  #    R(:q => 'Ruby', :page => 1) => '?q=Ruby&page=1'
  #    R(:q => ['first, 'second']) => '?q[]=first&q[]=second'
  #    R(:user => { :lname => 'Doe', :fname => 'John' })
  #    => '?user[lname]=Doe&user[fname]=John'
  #
  #    R("http://google.com/search", :q => "Robots")
  #    => 'http://google.com/search?q=Robots'
  #
  # @overload R()
  #   @return [String] returns the root '/'
  # @overload R(:arg1, :arg2, ..., :argN)
  #   @return [String] all args joined on '/' prefixed with '/'
  # @overload R(:arg1, :arg2, ..., :argN, hash)
  #   @param [#to_param] arg1 any object checked for #to_param, #id, and #to_s
  #   @param [#to_param] arg2 any object checked for #to_param, #id, and #to_s
  #   @param [#to_param] argN any object checked for #to_param, #id, and #to_s
  #   @param [Hash] hash to be represented as a query string.
  #   @return [String] all args joined on '/' with the hash represented
  #     as a query string.
  # @overload R(hash)
  #   @param [Hash] hash to be represented as a query string.
  #   @return [String] the hash represented as a query string, prefix with a `?`
  def R(*args)
    hash = args.last.is_a?(Hash) ? args.pop : {}

    return '?' + query_string(hash)  if hash.any? and args.empty?

    host_with_port = args.shift  if args.first =~ /^(https?|ftp)/

    path = args.unshift('/').map { |arg| to_param(arg) }.join('/').squeeze('/')

    path.tap do |ret|
      if hash.any?
        ret.gsub!(/^\//, '')  if ret == '/'
        ret << '?'
        ret << query_string(hash)
      end
      ret.insert(0, host_with_port.gsub(/\/$/, ''))  if host_with_port
    end
  end

private
  def query_string(hash)
    hash.inject([]) { |arr, (key, value)|
      if value.is_a?(Array)
        value.each do |e|
          arr << key_value("#{key}[]", e)
        end
        arr
      elsif value.is_a?(Hash)
        value.each do |namespace, deeper|
          arr << key_value("#{key}[#{namespace}]", deeper)
        end
        arr
      else
        arr << key_value(key, value)
      end
    }.join('&')
  end

  def key_value(k, v)
    '%s=%s' % [CGI.escape(k.to_s), URI.escape(to_param(v))]
  end

  # Primary difference of this method is that it checks if
  # the passed object has an :id method
  # after checking for a :to_param
  #
  def to_param_ruby19(object)
    if object.respond_to?(:to_param)
      object.to_param
    elsif object.respond_to?(:id)
      object.id
    else
      object.to_s
    end
  end
  
  # Since ruby 1.8 Objects all have a deprecated :id
  # method which is also the same as its :object_id
  # we can't just blindly check for an :id method
  def to_param_ruby18(object)
    if object.respond_to?(:to_param)
      object.to_param
    else
      object.to_s
    end
  end
  
  if RUBY_VERSION >= "1.9"
    alias to_param to_param_ruby19
  else
    alias to_param to_param_ruby18
  end
end
