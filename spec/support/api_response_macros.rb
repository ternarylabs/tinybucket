module ApiResponseMacros
  def stub_apiresponse(method, path, options = {})
    response_headers = { content_type: 'application/json' }.merge(options)

    stub_request(method, 'https://bitbucket.org/api/2.0' + path)
      .to_return(
        status: 200,
        body: fixture_json(method, path),
        headers: response_headers)
  end

  private

  def fixture_json(method, path)
    parts = path.split('?')

    path = 'spec/fixtures' + parts[0]
    fname = method.to_s
    fname += '_' + parts[1].gsub(/[\/??&=]/, '_') if parts[1].present?
    fname += '.json'

    File.read(path + '/' + fname)
  end
end