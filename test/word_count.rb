require 'net/http'

class WordCount
  attr_accessor :resp

  def initialize url
    @uri ||= URI(url)
  end

  def get
    begin
      @resp = Net::HTTP.get_response(@uri)
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
       Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
      @resp = nil
    end
    self
  end

  def success
    if @resp.nil? or @resp.code.to_i != 200
      false
    else
      true
    end
  end

  def body
    @resp ? @resp.body : ''
  end

  def wc w
    return 0 if @resp == nil
    words = @resp.body.gsub(/\s+/, ' ').strip.split(' ')
    words.count w
  end
end
