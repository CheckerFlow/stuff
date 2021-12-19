module ApplicationHelper
    require "mini_magick"

    def klarschiff_auto_link(string)
        result = ""
        options = {
            :hashtag_url_base => request.base_url + "/search/search?search_string=", 
            :hashtag_class => "badge badge-pill badge-light small",
            :username_url_base => request.base_url + "/search/search?search_string=",
            :username_class => "badge badge-pill badge-light small",
            :symbol_tag => true,
            :username_include_symbol => true
        }
        result = Twitter::TwitterText::Autolink.auto_link(string, options).html_safe
        return result 
    end

    def klarschiff_link_text_block(entity, text) 
        return text.reverse
    end

    # Return page-specific title text for <title>-tag in HTML <head> section
    def title(text)
        @title = text
    end

    def set_meta_description(text)
        @meta_description = text
    end

    # Resize images attached to a record
    def process_images(record_with_images_attached)
        record_with_images_attached.images.each do |image|
            
            begin
                image_metadata = ActiveStorage::Analyzer::ImageAnalyzer.new(image.blob).metadata
                if image_metadata[:width] > 1280
                    filename = image.filename.to_s
    
                    attachment_path = "#{Dir.tmpdir}/#{image.filename}"
    
                    File.open(attachment_path, 'wb') do |file|
                        file.write(image.blob.download)
                        file.close
                    end
    
                    new_image = MiniMagick::Image.open(attachment_path)
                        
                    new_image.resize "1280"
                    new_image.quality "85%"
                    new_image.interlace "JPEG" # Plane, JPEG
                    #new_image.gaussian_blur "0.05"
                    new_image.sampling_factor "4:2:0"
                    new_image.colorspace "RGB"
                    new_image.auto_orient
                    #new_image.strip
                    
                    new_image.write attachment_path          
        
                    image.purge_later
                    #record_with_images_attached.images.attach(io: File.open(attachment_path), filename: filename, content_type: "image/jpg")
                    record_with_images_attached.images.attach(io: File.open(attachment_path), filename: filename)
                end                
            rescue ActiveStorage::FileNotFoundError => e
                image.purge_later
            end            
        end
    end  
    
    MEGABYTES = 1024.0 * 1024.0

    def bytes_to_megabytes (bytes)
        bytes / MEGABYTES
    end
    
    def image_sizes(record_with_images_attached)
        total_size = 0

        record_with_images_attached.images.each do |image|
            total_size += image.blob.byte_size
        end

        return total_size
    end

end
