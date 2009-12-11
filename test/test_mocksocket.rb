$:.unshift 'lib'
require 'test/unit'
require 'mocksocket'

class TestMockSocket < Test::Unit::TestCase
  def setup
    @client, @server = MockSocket.pipe
  end

  def test_gets_and_puts
    @client.puts "hello, server!"
    assert_equal "hello, server!\n", @server.gets

    @client.print "I'll say more hello.\n"
    @client.print "and even more.\n"
    
    assert_equal "I'll say more hello.\n", @server.gets
    assert_equal "and even more.\n", @server.gets
  end

  def test_gets_timeout
    assert_raises(Timeout::Error) {@client.gets}
  end

  def test_eof?
    assert_raises(Timeout::Error) {@client.gets}

    @server.puts "goodies for you, client"
    assert_equal false, @client.eof?
  end
end
