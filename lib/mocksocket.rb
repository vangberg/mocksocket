require 'timeout'

class MockSocket
  TIMEOUT = 1

  def self.pipe
    socket1, socket2 = new, new
    socket1.in, socket2.out = IO.pipe
    socket2.in, socket1.out = IO.pipe
    [socket1, socket2]
  end

  attr_accessor :in, :out

  def puts(m) @out.puts(m) end

  def print(m) @out.print(m) end

  def gets
    timeout {@in.gets}
  end

  def read(length=nil)
    timeout {@in.read(length)}
  end

  def eof?
    timeout {@in.eof?}
  end

  def empty?
    begin
      @in.read_nonblock(1)
      false
    rescue Errno::EAGAIN
      true
    end
  end

  private
  def timeout(&block)
    Timeout.timeout(TIMEOUT) {block.call}
  end
end
