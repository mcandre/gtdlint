require 'rubygems'
require 'ptools'
require 'tempfile'

$stdout.sync = true

require 'version'

DEFAULT_IGNORES = %w(
  .hg/
  .svn/
  .git/
  .git
  .gtdlintignore
  .gtdlintrc.yml
  node_modules/
  .vagrant/
  Gemfile.lock
  .exe
  .bin
  .png
  .jpg
  .jpeg
  .svg
  .min.js
  -min.js
)

# Grep format, case insensitive
DEFAULT_GTD_PATTERN = "\'todo\\|to do\\|to-do\\|hack\'"

DEFAULT_LINES_BEFORE = 0
DEFAULT_LINES_AFTER = 0

DEFAULT_CONFIGURATION = {
  "gtd_pattern" => DEFAULT_GTD_PATTERN,
  "lines_before" => DEFAULT_LINES_BEFORE,
  "lines_after" => DEFAULT_LINES_AFTER
}

#
# Parse, model, and print a line too wide for its own good
#
class GTDThing
  attr_accessor :filename, :line_number, :line

  def self.parse(filename, grep_line)
    match = grep_line.match(/^(.+)\:(.+)$/)

    line_number = match[1]
    line = match[2]

    GTDThing.new(filename, line_number, line)
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

def self.recursive_list(directory, ignores = DEFAULT_IGNORES)
  Find.find(directory).reject do |f|
    File.directory?(f) ||
    ignores.any? { |ignore| f =~ %r(#{ignore}) } ||

    begin
      File.binary?(f)
    rescue Errno::ENOENT
      true
    end
  end
end

def self.check_stdin(configuration = DEFAULT_CONFIGURATION)
  gtd_pattern = configuration["gtd_pattern"]
  lines_before = configuration["lines_before"]
  lines_after = configuration["lines_after"]

  contents = $stdin.read

  t = Tempfile.new('aspelllint')
  t.write(contents)
  t.close

  filename = t.path

  output = `grep -B #{lines_before} -A #{lines_after} -n -i #{gtd_pattern} \"#{filename}\"`

  lines = output.split("\n")

  gtd_things = lines.map { |line| GTDThing.parse('stdin', line) }

  gtd_things.each { |m| puts m }
end

def self.check(filename, configuration = DEFAULT_CONFIGURATION)
  gtd_pattern = configuration["gtd_pattern"]
  lines_before = configuration["lines_before"]
  lines_after = configuration["lines_after"]

  output = `grep -B #{lines_before} -A #{lines_after} -n -i #{gtd_pattern} \"#{filename}\"`

  lines = output.split("\n")

  gtd_things = lines.map { |line| GTDThing.parse(filename, line) }

  gtd_things.each { |m| puts m }
end
