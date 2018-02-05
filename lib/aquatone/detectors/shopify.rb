module Aquatone
  module Detectors
    class Shopify < Aquatone::Detector
      self.meta = {
        :service         => "Shopify",
        :service_website => "https://shopify.com/",
        :author          => "Alessandro De Micheli (@eur0pa_)",
        :description     => "Shop hosting"
      }

      CNAME_VALUE          = ".myshopify.com".freeze
      RESPONSE_FINGERPRINT = "Sorry, this shop is currently unavailable".freeze

      def run
        return false unless cname_resource?
        if resource_value.end_with?(CNAME_VALUE)
          return get_request("http://#{host}/").body.include?(RESPONSE_FINGERPRINT)
        end
        false
      end
    end
  end
end
