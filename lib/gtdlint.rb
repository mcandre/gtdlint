require 'ptools'
require 'tempfile'

require_relative 'version'

DEFAULT_IGNORES = %w(
    tmp
    .hg
    .svn
    .git
    .gtdlintignore
    .gtdlintrc.yml
    node_modules
    bower_components
    target
    dist
    .vagrant
    Gemfile.lock
    *.exe
    *.bin
    *.apk
    *.ap_
    res
    *.class
    *.zip
    *.jar
    *.war
    *.xpi
    *.dmg
    *.pkg
    *.app
    *.xcodeproj
    *.lproj
    *.xcassets
    *.pmdoc
    *.dSYM
    *.jad
    *.cmo
    *.cmi
    *.png
    *.gif
    *.jpg
    *.jpeg
    *.tiff
    *.ico
    *.svg
    *.dot
    *.wav
    *.mp3
    *[.-]min.*
)

# Grep format, case insensitive
DEFAULT_GTD_PATTERN = "\'todo\\|to do\\|to-do\\|pending\\|hack\\|fixme\'"

DEFAULT_LINES_BEFORE = 0
DEFAULT_LINES_AFTER = 0

DEFAULT_CONFIGURATION = {
    'gtd_pattern' => DEFAULT_GTD_PATTERN,
    'lines_before' => DEFAULT_LINES_BEFORE,
    'lines_after' => DEFAULT_LINES_AFTER
}

#
# Parse, model, and print a line too wide for its own good
#
class GTDThing
    attr_accessor :filename, :line_number, :line

    def self.parse(filename, grep_line)
        if grep_line.match(/^--$/)
            grep_line
        else
            match = grep_line.match(/^([0-9]+)(\:|-)(.*)$/)

            line_number = match[1]
            line = match[3]

            GTDThing.new(filename, line_number, line)
        end
    end

    def initialize(filename, line_number, line)
        @filename = filename
        @line_number = line_number
        @line = line
    end

    def to_s
        "#{filename}:#{line_number}:#{line}"
    end
end

def self.check_stdin(configuration = nil)
    configuration =
    if configuration.nil?
        DEFAULT_CONFIGURATION
    else
        configuration
    end

    gtd_pattern = configuration['gtd_pattern']
    lines_before = configuration['lines_before']
    lines_after = configuration['lines_after']
    is_stat = configuration['is_stat']

    contents = $stdin.read

    t = Tempfile.new('gtdlint')
    t.write(contents)
    t.close

    filename = t.path

    output = `grep \
    -B #{lines_before} \
    -A #{lines_after} \
    -n \
    -i \
    -w #{gtd_pattern} \
    \"#{filename}\"
    `
    lines = output.split("\n")
    gtd_things = lines.map { |line| GTDThing.parse('stdin', line) }
    gtd_things.each { |m| puts m }
end

def self.check(filename, configuration = nil)
    configuration =
    if configuration.nil?
        DEFAULT_CONFIGURATION
    else
        configuration
    end

    gtd_pattern = configuration['gtd_pattern']
    lines_before = configuration['lines_before']
    lines_after = configuration['lines_after']
    is_stat = configuration['is_stat']

    output = `grep \
    -B #{lines_before} \
    -A #{lines_after} \
    -n \
    -i \
    -w #{gtd_pattern} \
    \"#{filename}\"
    `

    lines = output.split("\n")

    gtd_things = lines.map { |line| GTDThing.parse(filename, line) }

    gtd_things.each { |m| puts m }
end
