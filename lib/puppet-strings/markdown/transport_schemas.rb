require_relative 'transport_schema'

module PuppetStrings::Markdown
  module TransportSchemas

    # @return [Array] list of resource types
    def self.in_rtypes
      arr = YARD::Registry.all(:puppet_transport_schema).map!(&:to_hash)
      arr.map! { |a| PuppetStrings::Markdown::TransportSchema.new(a) }
    end

    def self.contains_private?
      result = false
      unless in_rtypes.nil?
        in_rtypes.find { |type| type.private? }.nil? ? false : true
      end
    end

    def self.render
      final = in_rtypes.length > 0 ? "## Transport Schema\n\n" : ""
      in_rtypes.each do |type|
        final << type.render unless type.private?
      end
      final
    end

    def self.toc_info
      final = ["Transport Schema"]

      in_rtypes.each do |type|
        final.push(type.toc_info)
      end

      final
    end
  end
end
