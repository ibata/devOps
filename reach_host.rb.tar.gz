# frozen_string_literal: true


control "reach_host" do
    title "Testing Endpoint"

    describe command("curl -sS https://ec2us-admin-demoluc.anaplan.com/administration/about.html") do
      its('stdout') { should_not match /HTTP Status 404/i }
      its('stderr') { should eq ''}
    end


end
