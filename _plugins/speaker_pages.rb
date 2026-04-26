# Generates a per-speaker detail page under /2026/speakers/{slug}/
# from _data/twenty_26/speakers.yml. The slug is the speaker name with
# whitespace replaced by hyphens; URL-encoding is left to Jekyll.

module Jekyll
  class SpeakerPage < Page
    def initialize(site, base, dir, speaker)
      @site = site
      @base = base
      @dir  = dir
      @name = 'index.html'

      self.process(@name)
      self.data = {
        'layout'  => '2026_speaker',
        'speaker' => speaker,
        'title'   => "#{speaker['name']} - Korea MCT Summit 2026",
        'sitemap' => true
      }
      self.content = ''
    end
  end

  class SpeakerPagesGenerator < Generator
    safe true
    priority :normal

    def generate(site)
      speakers = site.data.dig('twenty_26', 'speakers')
      return unless speakers.is_a?(Array)

      speakers.each do |speaker|
        name = speaker['name'].to_s.strip
        next if name.empty?
        slug = name.gsub(/\s+/, '-')
        site.pages << SpeakerPage.new(site, site.source, File.join('2026', 'speakers', slug), speaker)
      end
    end
  end
end
