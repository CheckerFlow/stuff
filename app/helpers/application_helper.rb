module ApplicationHelper

    def klarschiff_auto_link(string)
        options = {
            :hashtag_url_base => request.base_url + "/search/search?search_string=", 
            :hashtag_class => "badge badge-pill badge-light small",
            :username_url_base => request.base_url + "/search/search?search_string=",
            :username_class => "badge badge-pill badge-light small",
            :symbol_tag => true,
            :username_include_symbol => true
        }
        return Twitter::TwitterText::Autolink.auto_link(string, options).html_safe
    end

    def klarschiff_link_text_block(entity, text) 
        return text.reverse
    end
end
