require 'net/http'

class WordCount
  attr_accessor :resp

  def initialize url
    @uri ||= URI.parse(url)
    @http ||= Net::HTTP.new(@uri.host, @uri.port)
    @http.use_ssl = true
  end

  def get
    begin
      request = Net::HTTP::Get.new(@uri.request_uri)
      @resp = @http.request(request)
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
       Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
      @error = e
      @resp = nil
    end
    self
  end

  def success
    if @resp.nil? || @resp.code.to_i < 200 || @resp.code.to_i >= 300
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
