#!/bin/bash

# List of files without frontmatter
files=(
"rulebook/order-types-and-execution-rules/stop-market-order.mdx"
"rulebook/order-types-and-execution-rules/stop-limit-order.mdx" 
"rulebook/insurance-fund/insurance-fund-overview.mdx"
"rulebook/insurance-fund/insurance-fund-sources-and-growth.mdx"
"rulebook/insurance-fund/insurance-fund-operations.mdx"
"rulebook/auto-deleveraging-adl/adl-execution-process.mdx"
"rulebook/auto-deleveraging-adl/adl-overview-and-triggers.mdx"
"rulebook/auto-deleveraging-adl/adl-ranking-algorithm.mdx"
"rulebook/auto-deleveraging-adl/effect-on-affected-traders.mdx"
"rulebook/liquidation-mechanics/liquidation-process-steps.mdx"
"rulebook/liquidation-mechanics/execution-pricing-and-bankruptcy.mdx"
"rulebook/liquidation-mechanics/liquidation-triggers-and-overview.mdx"
"rulebook/trading-hours/reopening-after-closure-for-closed-hours-instruments.mdx"
"rulebook/risk-controls/pre-trade-order-controls.mdx"
"rulebook/risk-controls/position-and-open-interest-limits.mdx"
"rulebook/risk-controls/circuit-breakers-and-trading-halts.mdx"
"rulebook/risk-controls/post-trade-risk-management.mdx"
"rulebook/margin-rules/isolated-margin-mode.mdx"
"rulebook/margin-rules/margin-ratio-and-risk-management.mdx"
"rulebook/margin-rules/mark-price-and-p-and-l-settlement.mdx"
"rulebook/matching-engine-rules/price-time-priority.mdx"
"rulebook/matching-engine-rules/self-trade-prevention.mdx"
"rulebook/matching-engine-rules/order-matching-engine.mdx"
"rulebook/funding-payments/funding-rate-calculation.mdx"
"rulebook/funding-payments/funding-interval-and-timing.mdx"
"rulebook/funding-payments/funding-payment-calculation.mdx"
"rulebook/trading-fees-and-programs/overview.mdx"
)

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        # Extract title from first line (remove # and spaces)
        title=$(head -n 1 "$file" | sed 's/^# *//')
        
        # Create a brief description based on the title and first content line
        second_line=$(sed -n '3p' "$file" | sed 's/^[[:space:]]*//' | cut -c1-80)
        if [ -z "$second_line" ]; then
            second_line=$(sed -n '2p' "$file" | sed 's/^[[:space:]]*//' | cut -c1-80)
        fi
        
        # Create temporary file with frontmatter
        cat > temp_file << EOF
---
title: "$title"
description: "$second_line"
---

EOF
        
        # Append original content
        cat "$file" >> temp_file
        
        # Replace original file
        mv temp_file "$file"
        
        echo "Added frontmatter to: $file"
    fi
done

echo "Frontmatter added to all files!"