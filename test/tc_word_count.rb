require_relative 'word_count'
require 'test/unit'

class TestWordCount < Test::Unit::TestCase

  def setup
    @good = WordCount.new()
    @bad  = WordCount.new('http://bad.web.addr/nil')
  end

  def teardown
  end

  def test_methods
    assert_responds_to(@good, :get)
    assert_responds_to(@good, :body)
    assert_responds_to(@good, :success)
    assert_responds_to(@good, :wc)
  end

	def test_bad_uri
		assert_equal(false, @bad.get.success)
  end
end