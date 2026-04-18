#!/bin/bash
# OSINT Hub Setup Script

echo "=== OSINT Hub Setup ==="

# Core platforms
echo "[1/5] Installing core platforms..."
pip install spiderfoot bbot 2>/dev/null || echo "Note: Install Docker for IntelOwl/OpenCTI"

# Identity tools
echo "[2/5] Installing identity tools..."
pip install holehe theHarvester 2>/dev/null
go install github.com/sundowndev/phoneinfoga/v2/cmd/phoneinfoga@latest 2>/dev/null

# Breach tools
echo "[3/5] Installing breach tools..."
pip install h8mail 2>/dev/null
go install github.com/alpkeskin/mosint@latest 2>/dev/null

# Secret detection
echo "[4/5] Installing secret detection..."
brew install trufflehog 2>/dev/null || go install github.com/trufflesecurity/trufflehog/v3@latest 2>/dev/null

# Username search
echo "[5/5] Installing username tools..."
pip install blackbird 2>/dev/null

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Manual steps:"
echo "1. Deploy IntelOwl: https://github.com/intelowlproject/IntelOwl#quickstart"
echo "2. Deploy OpenCTI: https://github.com/OpenCTI-Platform/opencti#quickstart"
echo "3. Configure API keys in config/api-keys.yaml"
echo ""
echo "Start with: /osint <target>"
