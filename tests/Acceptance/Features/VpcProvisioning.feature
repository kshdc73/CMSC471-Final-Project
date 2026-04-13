Feature: VPC Infrastructure
  Scenario: Verify VPC CIDR Block
    Given the SAM template is initialized
    When the stack is deployed
    Then the AWS::EC2::VPC resource must have CidrBlock '10.0.0.0/16'