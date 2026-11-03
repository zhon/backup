module Backup

  class Mover

    # Rename +dest+ in place to match +src+'s basename when +src+ extends
    # +dest+'s name with extra descriptive text (e.g. dest "2022-07-02"
    # becomes "2022-07-02 More After"). Date-only sources are a no-op.
    # Returns the new destination path, or nil when nothing was moved.
    def self.move_destination(src, dest)
      return nil unless src && dest

      src = src.first if src.is_a?(Array)
      dest = dest.first if dest.is_a?(Array)

      src_name = File.basename(src.to_s)
      dest_name = File.basename(dest.to_s)
      return nil if src_name.empty? || dest_name.empty?
      return nil if src_name == dest_name
      return nil unless src_name.start_with?(dest_name)

      suffix = src_name[dest_name.length..-1]
      return nil if suffix.nil? || suffix.strip.empty?

      return nil unless File.directory?(dest.to_s)

      target = File.join(File.dirname(dest.to_s), src_name)
      if File.exist?(target)
        warn "Mover: target already exists, skipping: #{target}"
        return nil
      end

      File.rename(dest.to_s, target)
      target
    end

  end

end