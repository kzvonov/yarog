module Tg
  class Auth
    Result = Struct.new(:valid?, :user_data, :error, keyword_init: true) do
      def invalid?
        !valid?
      end
    end

    def self.validate(init_data)
      return Result.new(valid?: false, error: "Missing authentication data, close & open link again from the tg") if init_data.blank?

      parsed = URI.decode_www_form(init_data).to_h
      received_hash = parsed.delete("hash")

      data_check_string = parsed.sort.map { |k, v| "#{k}=#{v}" }.join("\n")
      bot_token = Rails.application.credentials.tg.yarog_bot_token!
      secret_key = OpenSSL::HMAC.digest("SHA256", "WebAppData", bot_token)
      expected_hash = OpenSSL::HMAC.hexdigest("SHA256", secret_key, data_check_string)

      if expected_hash != received_hash
        return Result.new(valid?: false, error: "Invalid authentication data, close & open link again from the tg")
      end

      # TODO: check the auth_date

      user_data = JSON.parse(parsed["user"])
      Result.new(valid?: true, user_data: user_data)
    end
  end
end
