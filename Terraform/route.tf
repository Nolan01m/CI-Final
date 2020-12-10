
/*resource "aws_route53_zone" "nhlabs" {
  name = "nhlabs.org"
}

resource "aws_route53_record" "Record1" {
  allow_overwrite = true
  name            = "nhlabs.org"
  ttl             = 30
  type            = "A"
  zone_id         = aws_route53_zone.nhlabs.zone_id

  records = ["*"]
}

resource "aws_route53_record" "Record2" {
  allow_overwrite = true
  name            = "nhlabs.org"
  ttl             = 30
  type            = "CNAME"
  zone_id         = aws_route53_zone.nhlabs.zone_id

  records = ["nhlabs.org"]
}
*/