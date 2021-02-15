control 'reach_host' do
  impact 1.0
  title 'This is Testing Endpoint'
  describe command("curl -sS https://ec2us-admin-demoluc.anaplan.com/administration/about.html") do
# comment   its('stdout') { should_not match /HTTP Status 404/i }
    its('stderr') { should eq ''}
  end
end
