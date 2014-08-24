Given(/^the program has finished$/) do
  # Test files are generated using iconv.
  @cucumber = `gtdlint examples/`
  @cucumber_stdin = `cat examples/hello.c | gtdlint`
  @cucumber_ignore_c = `gtdlint -i .c examples/`
  @cucumber_custom_pattern = `gtdlint -p pte examples/spanish/`
  @cucumber_before_after = `gtdlint -A 2 -B 2 examples/hello.c`
end

Then(/^the output is correct for each test$/) do
  cucumber_lines = @cucumber.split("\n")
  expect(cucumber_lines.length).to eq(4)
  expect(cucumber_lines[0]).to match(%r(^examples/hello.c\:[0-9]+\:.+$))

  cucumber_stdin_lines = @cucumber_stdin.split("\n")
  expect(cucumber_stdin_lines.length).to eq(3)
  expect(cucumber_stdin_lines[0]).to match(%r(^stdin:[0-9]+\:.+$))

  cucumber_ignore_c_lines = @cucumber_ignore_c.split("\n")
  expect(cucumber_ignore_c_lines.length).to eq(1)
  expect(cucumber_ignore_c_lines[0]).to match(%r(^examples/spanish/phrases.txt\:[0-9]+\:.+$))

  cucumber_custom_pattern_lines = @cucumber_custom_pattern.split("\n")
  expect(cucumber_custom_pattern_lines.length).to eq(1)
  expect(cucumber_custom_pattern_lines[0]).to match(%r(^examples/spanish/phrases.txt\:[0-9]+\:.+$))

  cucumber_before_after_lines = @cucumber_before_after.split("\n")
  expect(cucumber_before_after_lines.length).to eq(17)
  expect(cucumber_before_after_lines[2]).to match(%r(^examples/hello.c\:[0-9]+(\:|-).*$))
end
