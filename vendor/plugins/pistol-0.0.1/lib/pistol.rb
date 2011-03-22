class Pistol
  VERSION = "0.0.1"

  def initialize(app, files, &block)
    @app   = app
    @files = files.map { |file| File.expand_path(file) }
    @block = block
    @last  = last_mtime
  end

  def call(env)
    current = last_mtime

    if current > @last
      if Thread.list.size > 1
        Thread.exclusive { reload! }
      else
        reload!
      end

      @last = current
    end

    @app.call(env)
  end

private
  def reload!
    @files.each { |file| $LOADED_FEATURES.delete(file) }
    @block.call if @block
  end

  def last_mtime
    @files.map { |file| ::File.mtime(file) }.max
  end
end