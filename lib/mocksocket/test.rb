module MockSocket::Assertions
  def assert_empty_buffer(io)
    assert_raise(Errno::EAGAIN) { io.read_nonblock 1 }
  end
end
