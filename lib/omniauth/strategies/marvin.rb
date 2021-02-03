# frozen_string_literal: true

require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Marvin < OmniAuth::Strategies::OAuth2
      option :name, 'marvin'

      option :client_options, {
        site: ENV['MARVIN_SITE']
      }

      uid { raw_info['id'] }

      info do
        {
          name: raw_info['displayname'],
          email: raw_info['email'],
          nickname: raw_info['login'],
          location: raw_info['location'],
          image: raw_info['image_url'],
          phone: raw_info['mobile'],
          urls: {
            'Profile' => raw_info['url']
          }
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def callback_url
        full_host + script_name + callback_path
      end

      def raw_info
        @raw_info ||= access_token.get('v2/me').parsed
      end
    end
  end
end
