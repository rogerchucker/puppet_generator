Then /^I close the stdin stream$/ do
  @interactive.stdin.close()
end

Before do
  @aruba_timeout_seconds = 5
end
