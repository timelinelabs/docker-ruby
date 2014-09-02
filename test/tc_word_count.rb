require_relative 'word_count'
require 'test/unit'

class TestWordCount < Test::Unit::TestCase

  def setup
    @good = WordCount.new('https://gist.githubusercontent.com/albertrdixon/24c7f63b8a628f5bf348/raw/3bb99777d20238c76c70fd1d015b664a1afa09c6/random_text')
    @bad  = WordCount.new('http://bad.web.addr/nil')
  end

  def teardown
  end

  def test_methods
    assert_respond_to(@good, :get)
    assert_respond_to(@good, :body)
    assert_respond_to(@good, :success)
    assert_respond_to(@good, :wc)
  end

	def test_bad_uri
    assert_raise(SocketError) { @bad.get.success }
  end

  def test_word_count
    count = @good.get.wc('that')
    assert(@good.success)
    assert_equal(7, @good.get.wc('that'))
  end
end