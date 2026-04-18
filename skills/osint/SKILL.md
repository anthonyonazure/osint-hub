---
name: osint
description: Main OSINT investigation orchestrator - routes to specialist modules
version: "1.0"
author: anthonyonazure
---

# /osint - OSINT Investigation

## Usage

```
/osint <target>
/osint --type domain example.com
/osint --type email user@example.com
/osint --type username johndoe
/osint --type phone +1234567890
/osint --type org "Acme Corp"
```

## Procedure

### 1. Target Classification

Detect target type:
- Domain: contains `.` and no `@`
- Email: contains `@`
- Username: alphanumeric, no spaces
- Phone: starts with `+` or digits
- Organization: quoted string

### 2. Initialize Session

```json
{
  "session_id": "<uuid>",
  "target": "<target>",
  "target_type": "<domain|email|username|phone|org>",
  "started_at": "<ISO8601>",
  "findings": [],
  "entities": {
    "emails": [],
    "usernames": [],
    "domains": [],
    "phones": [],
    "social": []
  }
}
```

### 3. Route to Collectors

#### Domain Target
```bash
# SpiderFoot
spiderfoot -s <domain> -o json -q

# theHarvester
theHarvester -d <domain> -b all

# bbot
bbot -t <domain> -f safe
```

#### Email Target
```bash
# holehe - check 120+ sites
holehe <email> --only-used

# h8mail - breach check
h8mail -t <email>

# mosint
mosint <email>
```

#### Username Target
```bash
# blackbird - 300+ platforms
blackbird -u <username>

# sherlock (if installed)
sherlock <username>
```

#### Phone Target
```bash
# phoneinfoga
phoneinfoga scan -n <phone>
```

### 4. Enrich with IntelOwl

For each discovered indicator:
```bash
# Submit to IntelOwl
curl -X POST "http://localhost/api/analyze_observable" \
  -H "Authorization: Token <key>" \
  -d '{"observable_name": "<indicator>", "analyzers_requested": ["VirusTotal", "Shodan", "AbuseIPDB"]}'
```

### 5. Build Entity Graph

Extract and link:
- Emails → Domains
- Usernames → Social profiles
- Domains → Subdomains → IPs
- Phones → Carrier, location

### 6. Store in OpenCTI

```graphql
mutation {
  stixCyberObservableAdd(input: {
    type: "Email-Addr"
    value: "<email>"
    labels: ["osint-discovered"]
  })
}
```

### 7. Generate Report

```markdown
# OSINT Investigation Report

## Target: <target>
## Date: <date>

### Executive Summary
<findings overview>

### Discovered Entities

#### Emails (12 found)
- user@example.com (used on: LinkedIn, Twitter, GitHub)
- admin@example.com (breached: 2 times)

#### Domains (5 found)
- example.com (main)
- mail.example.com (MX)
...

### Breach Exposure
<h8mail results>

### Social Profiles
<blackbird/holehe results>

### Recommendations
1. <action items>
```

### 8. Output

```
[OSINT Hub] Investigation complete
Target: <target>
Type: <type>

Discovered:
  Emails: <n>
  Domains: <n>
  Social: <n>
  Breaches: <n>

Report: ./reports/<session_id>.md
OpenCTI: <entity_link>

Next: /osint-breach <email> for deep dive
```
