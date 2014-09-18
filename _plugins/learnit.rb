module Jekyll
  module Tags
    class LearnIt < Liquid::Tag
      include Liquid::StandardFilters

      def initialize(tag_name, markup, tokens)
        super
        @url = markup

      end

      def render(context)
        output = "<a href=\"#{@url}"
        output << "\"><i class=\"fa fa-university fa-lg\"></i>Learn more</a>"
      end


    end
  end
end

Liquid::Template.register_tag('learnit', Jekyll::Tags::LearnIt)
