require "spec_helper"
require "omniauth-marvin"

describe OmniAuth::Strategies::Marvin do
  let(:request) { double('Request', :params => {}, :cookies => {}, :env => {}) }

  subject do
    args = ['appid', 'secret', @options || {}].compact
    OmniAuth::Strategies::Marvin.new(*args).tap do |strategy|
      allow(strategy).to receive(:request) {
        request
      }
    end
  end

  describe "client options" do
    it 'has a correct name' do
      expect(subject.options.name).to eq("marvin")
    end

    it 'has a correct site' do
      expect(subject.options.client_options.site).to eq("https://api.intrav2.42.fr")
    end

    it "has a valid auth url" do
      expect(subject.options.client_options.authorize_path).to eq("v2/oauth/authorize")
    end
  end
end