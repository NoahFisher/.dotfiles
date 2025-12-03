MY ROADMAP 2025/6
===

TODO:
* Bugsnag in staging
* Datadog in staging
* Logs in staging
* Resource end to end?

document the server
## VERIFICATION OF BENEFITS
- Continue working the data pipeline and feature generation
- Ideas to solve:
    - Historical Patient Responsibility Anchoring
    - Component-Wise Multi-Task Learning
- Look into another payer to see how well results translate (multi-payer)

## LLM AMADEUS:
- Assist Kade with launching Amadeus

## HOW WE WORK:
- RESOURCE MAPS
  - Provide engineering with a tool to produce resource maps for what engineers are working on
- REPORTING
  - take daily/weekly snapshots and provide Anne a view of dates and committment to delivery
- HIRING ROADMAP
  - provide a centralized place for hiring roadmap source of truth to exist
- SQUAD ASSIGNMENTS
  - provide a centralized place for squad assigments to be set (along with roles)

## SELECTIVE TEST RUNNING
- selectively run tests just for the code paths that you changed

## BLOG / WRITING OPPORTUNITIES
- Simply, Engineering - we are what we make, and we make believe
- Simply, Building



```bash
# `/root/outerbounds/aws/config`
[profile bedrockuser]
source_profile = task
role_arn = arn:aws:iam::461835865108:role/obp-task-devs

export CLAUDE_CODE_USE_BEDROCK=1
export AWS_PROFILE=bedrockuser
```


BUNDLE_BUILD__RUBY-ODBC: "--with-odbc-dir=/opt/homebrew/opt/libiodbc"

# Dependencies and Obscurity
- Dependencies: when one part of the system relies on another, making it difficult to change or update
- Obscurity: when important information is not obvious

To run fastboot test:
in simplepractice:
```bash
sp -e FASTBOOT=true -e CONFIG__CLIENT_PORTAL__HOST=client-portal.local rspec spec/features/client_portal_app/home_spec.rb
```

in client-portal:
```bash
sp -e PUBLIC_ASSET_URL=http://client-portal.local:4200/ -e RAILS_ENV=test yarn start -- --port 4200 --proxy http://client-portal-app.simplepractice.local:4201
```

===
Stripe Cards
| Card Number      | Role                   |
| ---------------- | --------               |
| 4000000000000259 | Disputed               |
| 4000000000001976 | Dispute Inquiry        |
| 4000003720000278 | Add to balance         |
| 4000000000000077 | Bypass pending balance |
| 4242424242424242 | Payment                |
| winning_evidence | string for dispute evidence |
| 4000000000000002 | failed_payment   |


Brakeman Ignore:
===
`brakeman -I`

Availity coverage testing
---
| Subscriber id             | Status Code | Description                                                                                      |
| --------------------      | ----------- | -----------                                                                                      |
| Coverages-Complete-i      | 200         | Availity has successfully retrieved the member_s coverage information from the health plan.      |
| Coverages-PayerError1-i   | 200         | The health plan has indicated that the provider is ineligible for inquiries.                     |
| Coverages-PayerError2-i   | 200         | The health plan has indicated that the subscriber name is invalid.                               |
| Coverages-InProgress-i    | 202         | Availity is in the process of retrieving the member_s coverage information from the health plan. |
| Coverages-Retrying-i      | 202         | The health plan did not respond so Availity is retrying the request.                             |
| Coverages-RequestError1-i | 400         | Your request failed Availity_s input validation rules.                                           |
| Coverages-RequestError2-i | 400         | Your request failed Availity's input validation rules. |

Eligible Enrollment testing
---
| MEMBER ID  | DESCRIPTION                                  |
| ---        | ---                                          |
| U44441234  | enrollment required                          |
| U12121212  | insured not found                            |
| U1212ERR72 | Invalid/Missing Subscriber Id. Error code 72 |
| AETNA00HMO | Aetna plan: HMO                              |

Eligible coverage report testing
---
| MEMBER ID      | RETURNS                     |
| ---            | ---                         |
| U44441234      | enrollment required                     |
| 94532189A      | Duplicate eligibility requests using the same NPI/HICN combination in the same day |
| 111111111A     | Medicare Advantage (all claims should be processed to Managed Care Organization) |
| 121111211A     | Primary payer othen than Medicare |
| 333333333A     | Active traditional part A and B Medicare |
| 4444444444A    | Part D plan |
| 4747474747A    | Patient has passed away |
| 77777777A      | Primary payer (insurance company) which is not Medicare (all claims should go to Primary first) |
| 9999999999A    | Active traditional Part A & B |

Eligible claim subscriber ids
---
| MEMBER ID      | RETURNS                     |
| ---            | ---                         |
| 89898989     | Claim has been completed and paid. |
| 98989898     | Claim has been completed and paid. |
| 919191919    | Claim has been completed and denied. |
| 121212121    | Claim has been completed and paid with multiple adjustments. |
| 12312312     | Rejected due to duplicate of a previously processed claim/line. |
| 212121212    | Claim has been completed and paid and received multiple ERAs. |
| 45454545     | Rejected Report with Rejection Radar Signal. |
| 56565656     | Rejected and not accepted into adjudication system. |

Eligible claim subscriber ids BCBS (blue cross blue shield specifics)
---
---
| MEMBER ID      | RETURNS                     |
| ---            | ---                         |
| R21453657    | Claim has been completed and paid. |
| AQV956245    | Claim has been completed and paid. |

Eligible claim subscriber ids for claim denials
---
---
| MEMBER ID      | RETURNS                     |
| ---            | ---                         |
| U12121212    | Patient not found by the insurer. |
| U1212ERR72   | Invalid/Missing Subscriber Id. |
| U0INACTIVE   | The insurance policy was not active on the date of service specified in the insurance claim. |
| IN0PAYER     | The insurance company you selected recommends you submit the claim to a different insurer. |

Hacks
===

Make large file:
```ruby
# Create a 1M fill buffer
fills = '1'*1048576
File.open("file-#{ARGV[0]}M.txt", 'w') do |f|
  (15).times {f.write(fills) }
end
```

KMS (encrypt/decrypt)
===

Prod:
```
AWS_PROFILE=prod_phi aws kms encrypt --key-id alias/simplepractice --plaintext '<insert string here>' --region us-west-2 --output text --query CiphertextBlob
```

```
AWS_PROFILE=prod_phi aws kms decrypt --ciphertext-blob fileb://<(echo '<insert encoded string here>' | base64 -d) --region us-west-2 --output text --query Plaintext | base64 -d
```

Change AWS_PROFILE to the correct environment (staging/preprod/prod_phi)


MYSQL uncompress
===

```sql
SELECT
	convert(uncompress(concat(unhex('0900000'),data)) using utf8mb4)
FROM
	audit_attributes
	INNER JOIN audits ON audits.id = audit_attributes.audit_id
WHERE
	practice_id = 305029
	AND auditable_id = 116687248;
```
