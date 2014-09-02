require 'net/http'

class WordCount
  def initialize url
    @uri ||= URI(url)
  end

  def get
    begin
      @resp = Net::HTTP.get_response(@uri)
    rescue
      @resp = nil
    end
    self
  end

  def success
    begin
      return true if @resp.value
    rescue
      return false
    end
  end

  def body
    @resp ? @resp.body : ''
  end

  def wc w
    return 0 if @resp == nil
    words = @resp.gsub(/\s+/, ' ').strip.split(' ')
    words.count w
  end
end
