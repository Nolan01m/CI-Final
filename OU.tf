resource "aws_organizations_account" "account" {
  name  = "nhlabs"
  email = "nolan@nhlabs.org"
}
/*
resource "aws_organizations_organization" "org" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
  ]

  feature_set = "ALL"
}
resource "aws_organizations_organizational_unit" "nhlabs" {
  name      = "students"
  parent_id = aws_organizations_organization.org.roots[0].id
}
*/