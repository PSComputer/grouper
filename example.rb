require 'aws-sdk'
require 'grouper'
include Grouper 

AWS.config(YAML.load(File.read('path/to/credentials/aws.yml'))) #your AWS credentials

wormly_ips = ['178.79.181.14/32', '103.1.185.241/32', '184.72.226.23/32', '66.246.75.38/32', '74.82.3.54/32', '74.207.230.51/32', '69.164.195.159/32', '184.73.218.144/32']

github_ips = ['207.97.227.224/27', '173.203.140.192/27', '204.232.175.64/27', '72.4.117.96/27']

wormly = [Rule.new(:tcp, 443, wormly_ips, :in)]

github = [ Rule.new(:tcp, 22, github_ips, :in),
           Rule.new(:tcp, 80, github_ips, :in),
           Rule.new(:tcp, 443, github_ips, :in)]
           
ec2 = AWS::EC2.new(:ec2_endpoint => "ec2.eu-west-1.amazonaws.com")
intranet_server = find_or_create(ec2, 'intranet_server')
rules = wormly + github + ubuntu_updates
apply_rules(intranet_server, rules)


           

          
