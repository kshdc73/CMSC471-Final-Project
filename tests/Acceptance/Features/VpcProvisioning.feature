Feature: VPC Infrastructure
  Scenario: Verify VPC CIDR Block
    Given the SAM template is initialized
    When the stack is deployed
    Then the AWS::EC2::VPC resource must have CidrBlock '10.0.0.0/16'


  Scenario: Verify Public Subnet CIDR Block
    Given the SAM template is initialized
    When the stack is deployed
    Then the AWS::EC2::Subnet resource must have CidrBlock '10.0.1.0/24'

  Scenario: Verify Private Subnet CIDR Block
    Given the SAM template is initialized
    When the stack is deployed
    Then the AWS::EC2::Subnet resource must have CidrBlock '10.0.2.0/24'
  
  Scenario: Verify Public Internet Access Route
    Given the SAM template is initialized
    When the stack is deployed
    Then the AWS::EC2::Route resource must have DestinationCidrBlock '0.0.0.0/0'
    And the GatewayId must reference 'MyInternetGateway'
  
  Scenario: Verify Web Server Security Group Rules
    Given the SAM template is initialized
    When the stack is deployed
    Then the AWS::EC2::SecurityGroup resource must have Ingress rules for port 80
    And the AWS::EC2::SecurityGroup resource must have Ingress rules for port 22
  

  Scenario: Verify Web Server Instance Configuration
    Given the SAM template is initialized
    When the stack is deployed
    Then the AWS::EC2::Instance resource must exist
    And the InstanceType must be 't2.micro'
    And it must be associated with 'PublicSubnet'

  Scenario: Verify Web Server Software Installation
    Given the EC2 instance is provisioned
    When the UserData script executes
    Then the server should be listening on port 80
    And the index.html file must contain 'IUP Bulletin Board'