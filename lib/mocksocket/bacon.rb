require 'bacon'

class Bacon::Context
  def empty_buffer
    lambda {|io|
      should.raise(Errno::EAGAIN) {io.read_nonblock 1}
    }
  end
end
