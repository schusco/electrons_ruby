module ApplicationHelper
  def normalize_innings(ip)
    return ip if ip.nil?
    whole_innings = ip.to_i
    fractional_innings = ((ip - whole_innings) * 3).round
    if fractional_innings == 3
      whole_innings += 1
      fractional_innings = 0
    end
    "#{whole_innings}.#{fractional_innings}"
  end
  def stat_label(display)
    if display == "Player"
      return "Year"
    end
    "Player"
  end
  def carousel(path)
    files = Dir.glob("#{path}/*")  # Get all files in the folder
    return "" if files.empty?

    content_tag(:div, id: "carousel-example-generic", class: "carousel slide align-content-center", data: { ride: "carousel" }) do
      # Carousel indicators (dots)
      indicators = content_tag(:ol, class: "carousel-indicators") do
        files.each_with_index.map do |_, i|
          class_name = i.zero? ? "active" : ""
          tag.li("", data: { target: "#carousel-example-generic", slide_to: i }, class: class_name)
        end.join.html_safe
      end

      # Carousel items
      items = content_tag(:div, class: "carousel-inner") do
        files.each_with_index.map do |file, i|
          class_name = i.zero? ? "carousel-item active" : "carousel-item"
          filename = File.basename(file)
          folder = path.sub(%r{^public/}, "") # Remove 'public/' prefix if present
          web_path = "/#{folder}/#{filename}" # Convert to web path
          # img_src = File.join("/", web_path) # Adjust path for Rails public/assets if needed
          content_tag(:div, class: class_name) do
            image_tag(web_path, alt: "slide #{i}", class: "tronCarouselImage d-block ")
          end
        end.join.html_safe
      end

      # Prev/Next controls
      controls = "".html_safe
      controls << link_to("#carousel-example-generic", class: "carousel-control-prev", role: "button", data: { slide: "prev" }) do
        tag.span("", class: "carousel-control-prev-icon", aria: { hidden: "true" })
        # tag.span("Previous", class: "sr-only")
      end
      controls << link_to("#carousel-example-generic", class: "carousel-control-next", role: "button", data: { slide: "next" }) do
        tag.span("", class: "carousel-control-next-icon", aria: { hidden: "true" })
        # tag.span("Next", class: "sr-only")
      end

      # Combine all parts
      indicators + items + controls
    end
  end
end
