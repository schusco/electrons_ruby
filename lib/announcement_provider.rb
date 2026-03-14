class AnnouncementProvider
  @file_path = Rails.root.join("config", "settings.yml")
  @cached_text = nil
  @last_mtime = nil

  def self.text
    current_mtime = File.mtime(@file_path)

    # Only reload if we've never loaded it OR the file has been modified
    if @last_mtime.nil? || current_mtime > @last_mtime
      puts "--- RELOADING SETTINGS.YML FROM DISK ---" # You'll see this in your terminal
      settings = YAML.load_file(@file_path)
      @cached_text = settings.dig("shared", "announcement")
      @last_mtime = current_mtime
    end

    @cached_text
  rescue => e
    puts(e)
    "Winnemac Electrons Baseball"
  end
end
