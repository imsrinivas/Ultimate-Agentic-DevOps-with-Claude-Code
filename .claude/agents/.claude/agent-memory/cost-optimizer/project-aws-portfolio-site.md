---
name: portfolio-site-cost-review
description: Cost optimization analysis for static portfolio website on AWS (S3 + CloudFront)
metadata:
  type: project
  date_reviewed: 2026-07-11
---

# Portfolio Site AWS Cost Optimization Review

## Project Details
- **Architecture**: Static HTML/CSS portfolio website
- **Deployment**: S3 + CloudFront + Terraform
- **Region**: ap-south-1 (Mumbai)
- **Estimated Annual Savings**: $30-108/year

## Key Cost Drivers Identified

### 1. S3 Versioning (HIGH IMPACT)
**Problem**: Versioning enabled on static website bucket stores every version of every object, inflating storage costs unnecessarily.
- **Current State**: Line 22-28 of main.tf has versioning enabled
- **Fix**: Disable or remove `aws_s3_bucket_versioning` resource
- **Savings**: $0.75-2.00/month (~$9-24/year)
- **Why it matters**: For a portfolio site with infrequent changes, version history has no business value but adds 50-100% to storage costs

### 2. CloudFront Price Class (MEDIUM IMPACT)
**Problem**: Using PriceClass_200 (mid-tier) when PriceClass_100 (cheapest) would be sufficient.
- **Current State**: Line 69 of main.tf: `price_class = "PriceClass_200"`
- **Fix**: Change to `price_class = "PriceClass_100"`
- **Savings**: 10-15% reduction in CloudFront costs (~$1-3/month)
- **Why it matters**: Portfolio sites don't need Australia/New Zealand edge coverage; PriceClass_100 covers 95% of users globally

### 3. Missing S3 Lifecycle Policy (MEDIUM IMPACT IF VERSIONING KEPT)
**Problem**: No automatic cleanup of old versions or transition to cheaper storage tiers.
- **Current State**: No lifecycle configuration present
- **Fix**: Add `aws_s3_bucket_lifecycle_configuration` resource to delete noncurrent versions after 30 days
- **Savings**: $1-3/month (if versioning remains enabled)
- **Why it matters**: Compounds versioning cost problem; old versions never cleaned up

### 4. CloudFront Cache Policy Optimization (LOW IMPACT)
**Problem**: Not explicitly optimizing cache behavior for static assets.
- **Current State**: Using Managed-CachingOptimized policy (good default)
- **Opportunity**: Add custom behaviors for CSS/JS with longer TTLs to reduce origin requests
- **Savings**: $0.50-1.00/month
- **Why it matters**: Static files never change; longer TTLs = fewer CloudFront→S3 requests = lower data transfer

## Cost Patterns in This Project

1. **Security prioritized correctly over cost**: Public access block, versioning intent shows security mindfulness (good)
2. **Good caching setup**: Compress enabled, CachingOptimized policy selected (best practices)
3. **Oversized for actual needs**: PriceClass_200 unnecessarily broad for portfolio site
4. **Versioning not disabled by default**: Most projects that add versioning forget to justify it or clean up old versions

## Recommendations in Priority Order

### Quick Wins (2 minutes to implement)
1. **Change PriceClass_200 → PriceClass_100** (main.tf:69)
2. **Remove aws_s3_bucket_versioning** (main.tf:22-28)
   - **Alternative**: If versioning needed for compliance, add lifecycle rule to delete noncurrent versions after 30 days

### Medium Effort
3. Add S3 lifecycle configuration to delete old versions
4. Consider custom CloudFront behaviors for static assets with 1-year TTLs

## Regional Considerations
- ap-south-1 region is appropriate for portfolio site
- No cross-region considerations needed
- PriceClass_100 still covers ap-south-1 adequately

## Related Memory
- [[static-site-cloudfront-strategies]] - Future optimizations for high-traffic scenarios
