module Agents
  class CoinmarketcapAgent < Agent
    include FormConfigurable
    default_schedule "every_10m"

    cannot_receive_events!


    description <<-MD
      The coinmarketcap agent creates an event for day's cryptocurrencies prices using coinmarketcap API.
      In order to use this agent, you must set up an [API key for coinmarketcap](https://www.coinmarketcap.com/api) 
      to authenticate yourself
        
    MD

    event_description <<-MD
      Events look like this:
          "status": {
        "timestamp": "2020-03-14T18:26:18.493Z",
        "error_code": 0,
        "error_message": null,
        "elapsed": 18,
        "credit_count": 1,
        "notice": null
    },
    "data": [
        {
            "id": 1,
            "name": "Bitcoin",
            "symbol": "BTC",
            "slug": "bitcoin",
            "num_market_pairs": 7807,
            "date_added": "2013-04-28T00:00:00.000Z",
            "tags": [
                "mineable"
            ],
            "max_supply": 21000000,
            "circulating_supply": 18270512,
            "total_supply": 18270512,
            "platform": null,
            "cmc_rank": 1,
            "last_updated": "2020-03-14T18:25:38.000Z",
            "quote": {
                "USD": {
                    "price": 5467.79362916,
                    "volume_24h": 40800433999.7248,
                    "percent_change_1h": 1.20477,
                    "percent_change_24h": 6.03836,
                    "percent_change_7d": -39.2263,
                    "market_cap": 99899389115.09132,
                    "last_updated": "2020-03-14T18:25:38.000Z"
                }
            }
        },
        {
            "id": 1027,
            "name": "Ethereum",
            "symbol": "ETH",
            "slug": "ethereum",
            "num_market_pairs": 5194,
            "date_added": "2015-08-07T00:00:00.000Z",
            "tags": [
                "mineable"
            ],
            "max_supply": null,
            "circulating_supply": 110094587.874,
            "total_supply": 110094587.874,
            "platform": null,
            "cmc_rank": 2,
            "last_updated": "2020-03-14T18:25:23.000Z",
            "quote": {
                "USD": {
                    "price": 129.412142464,
                    "volume_24h": 14844314993.3237,
                    "percent_change_1h": 0.75132,
                    "percent_change_24h": 5.18676,
                    "percent_change_7d": -46.4283,
                    "market_cap": 14247576490.465454,
                    "last_updated": "2020-03-14T18:25:23.000Z"
                }
            }
        }...
    MD

    def default_options
      {
        "api_domain" => "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest",
        "api_key" => ""
      }
    end

    form_configurable :api_domain
    form_configurable :api_key

    def validate_options
      errors.add(:base, "You need to specify a api key") unless options['api_key'].present?
      errors.add(:base, "You need to specify a API domain") unless options['api_domain'].present?
    end

    def working?
      # Implement me! Maybe one of these next two lines would be a good fit?
      # checked_without_error?
      received_event_without_error?
    end

    def check
      response = HTTParty.get(event_url, request_options)
      events = JSON.parse response.body
      create_event :payload => events
    end

  private

    def event_url
      options['api_domain']
    end

    def request_options
      {:headers => {"X-CMC_PRO_API_KEY" => options['api_key'], "Content-Type"=>"application/json"} }
    end

  end
end
