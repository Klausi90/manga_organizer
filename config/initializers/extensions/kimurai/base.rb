module Kimurai
  class Base

    def request_to(handler, delay = nil, url:, data: {}, response_type: :html)
      raise InvalidUrlError, "Requested url is invalid: #{url}" unless URI.parse(url).kind_of?(URI::HTTP)

      if @config[:skip_duplicate_requests] && !unique_request?(url)
        add_event(:duplicate_requests) if self.with_info
        logger.warn "Spider: request_to: not unique url: #{url}, skipped" and return
      end

      visited = delay ? browser.visit(url, delay: delay) : browser.visit(url)
      return unless visited

      public_send( handler, browser.current_response(response_type), **{ url: url, data: data })
    end

  end
end
