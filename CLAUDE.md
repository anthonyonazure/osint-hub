# OSINT Intelligence Hub

Unified OSINT reconnaissance and investigation platform combining open-source intelligence tools with threat intelligence platforms.

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    OSINT Intelligence Hub                    │
├─────────────────────────────────────────────────────────────┤
│  Orchestration Layer                                         │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐        │
│  │SpiderFoot│  │  bbot   │  │ Crucix  │  │ reNgine │        │
│  └────┬────┘  └────┬────┘  └────┬────┘  └────┬────┘        │
│       │            │            │            │              │
├───────┴────────────┴────────────┴────────────┴──────────────┤
│  Intelligence Platform                                       │
│  ┌─────────────────┐  ┌─────────────────┐                   │
│  │    IntelOwl     │  │    OpenCTI      │                   │
│  │  (Enrichment)   │  │ (Graph Storage) │                   │
│  └────────┬────────┘  └────────┬────────┘                   │
│           └──────────┬─────────┘                            │
│                      ▼                                      │
├─────────────────────────────────────────────────────────────┤
│  Specialist Tools                                            │
│  Identity    │ Breach    │ Secrets    │ Dark Web            │
│  ──────────  │ ────────  │ ──────────│ ─────────           │
│  holehe      │ h8mail    │ trufflehog │ robin               │
│  blackbird   │ pwnedOrNot│ keyFinder  │ TorBot              │
│  phoneinfoga │ mosint    │ shhgit     │                     │
│  theHarvester│           │ gitGraber  │                     │
└─────────────────────────────────────────────────────────────┘
```

## Quick Start

```bash
# Initialize investigation
/osint <target_domain_or_email_or_username>

# Or run specific modules
/osint-identity <username>      # Username/email lookup
/osint-breach <email>           # Breach & credential exposure
/osint-secrets <github_org>     # Secret scanning
/osint-darkweb <query>          # Dark web search
```

## Tools Integration

### Core Platforms

| Tool | Purpose | Install |
|------|---------|---------|
| [SpiderFoot](https://github.com/smicallef/spiderfoot) | OSINT automation | `pip install spiderfoot` |
| [IntelOwl](https://github.com/intelowlproject/IntelOwl) | Threat intel enrichment | Docker compose |
| [OpenCTI](https://github.com/OpenCTI-Platform/opencti) | CTI platform & graph | Docker compose |
| [bbot](https://github.com/blacklanternsecurity/bbot) | Recursive scanner | `pip install bbot` |
| [Crucix](https://github.com/calesthio/Crucix) | Personal intel agent | Python |

### Identity Tools

| Tool | Purpose | Install |
|------|---------|---------|
| [holehe](https://github.com/megadose/holehe) | Email site checker | `pip install holehe` |
| [blackbird](https://github.com/p1ngul1n0/blackbird) | Username search | `pip install blackbird` |
| [phoneinfoga](https://github.com/sundowndev/phoneinfoga) | Phone OSINT | Go binary |
| [theHarvester](https://github.com/laramies/theHarvester) | Email/subdomain enum | `pip install theHarvester` |

### Breach Tools

| Tool | Purpose | Install |
|------|---------|---------|
| [h8mail](https://github.com/khast3x/h8mail) | Email breach hunting | `pip install h8mail` |
| [pwnedOrNot](https://github.com/thewhiteh4t/pwnedOrNot) | HIBP checker | Python |
| [mosint](https://github.com/alpkeskin/mosint) | Email OSINT | Go binary |

### Secret Detection

| Tool | Purpose | Install |
|------|---------|---------|
| [trufflehog](https://github.com/trufflesecurity/trufflehog) | Credential detection | Go binary |
| [keyFinder](https://github.com/momenbasel/keyFinder) | Browser extension | Chrome/Firefox |
| [shhgit](https://github.com/eth0izzle/shhgit) | GitHub secrets | Go binary |
| [gitGraber](https://github.com/hisxo/gitGraber) | Real-time GitHub | Python |

### Dark Web

| Tool | Purpose | Install |
|------|---------|---------|
| [robin](https://github.com/apurvsinghgautam/robin) | AI dark web OSINT | Python |
| [TorBot](https://github.com/DedSecInside/TorBot) | .onion crawler | Python |

## Workflow

### 1. Target Intake
```bash
# Domain investigation
/osint example.com

# Person investigation  
/osint-person "John Doe" --email john@example.com

# Organization
/osint-org "Acme Corp" --domains acme.com,acmecorp.io
```

### 2. Automated Collection
SpiderFoot runs first, feeding results to IntelOwl for enrichment:
- Subdomain enumeration
- Email harvesting
- Social media discovery
- Technology fingerprinting

### 3. Identity Pivot
For each discovered email/username:
```bash
holehe <email>           # Check 120+ sites
blackbird -u <username>  # Search 300+ platforms
phoneinfoga scan -n <phone>
```

### 4. Breach Analysis
```bash
h8mail -t <email>        # Check breach databases
pwnedOrNot -e <email>    # HIBP + password search
```

### 5. Secret Hunting
```bash
trufflehog github --org=<target>
gitGraber.py -k <keywords>
```

### 6. Intelligence Correlation
All findings flow to OpenCTI for:
- Entity relationship mapping
- Timeline construction
- Indicator correlation

## Output

Results stored in:
- `./osint-session.json` - Raw findings
- `./reports/` - Generated reports
- OpenCTI - Graph database

## Configuration

### API Keys (Optional but Recommended)

```yaml
# config/api-keys.yaml
haveibeenpwned: <key>
shodan: <key>
virustotal: <key>
hunter: <key>
fullcontact: <key>
```

### IntelOwl Analyzers

Enable these analyzers in IntelOwl:
- VirusTotal
- Shodan
- URLhaus
- AbuseIPDB
- GreyNoise

## Skills

| Skill | Description |
|-------|-------------|
| /osint | Main investigation skill |
| /osint-identity | Username/email lookup |
| /osint-breach | Credential exposure check |
| /osint-secrets | GitHub/GitLab secret scan |
| /osint-darkweb | Dark web search |
| /osint-report | Generate investigation report |
