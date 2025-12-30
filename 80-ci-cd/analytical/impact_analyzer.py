# artefact_type: implementation
# visibility: public
# audience: everyone
# form: source
# role: implementation
# status: informative
# owner: ci-cd-automation
# ------------------------------------------------------------------------------
# DISCLAIMER:
# This file is an ILLUSTRATIVE EXAMPLE of an Impact Analysis Engine.
# It simulates the logic of calculating "Blast Radius" for a change.
# ------------------------------------------------------------------------------

import sys
import json

# Mock Dependency Graph (The "Brain" of the system)
DEPENDENCY_GRAPH = {
    "SPEC-OB-FUNC": {
        "downstream": [
            "COMP-PSP-01 (Gateway)",
            "COMP-EUR-02 (Alias Service)",
            "COMP-EUR-04 (DESP)",
            "Rule ONB-01 (Single Identity)"
        ],
        "criticality": "HIGH"
    }
}

THRESHOLD = 3

def analyze_impact(spec_id):
    print(f"[Parsed] Analyzing Impact for change in: {spec_id}")
    
    node = DEPENDENCY_GRAPH.get(spec_id)
    if not node:
        print(f"[Info] No known dependencies for {spec_id}. Safe to merge.")
        return

    impacted = node["downstream"]
    count = len(impacted)
    
    print(f"[Graph] Found {count} downstream dependencies:")
    for dep in impacted:
        print(f"  - {dep}")

    if count > THRESHOLD:
        print("\n" + "!" * 50)
        print(f"WARNING: HIGH IMPACT CHANGE DETECTED (Blast Radius: {count})")
        print("ACTION: MANDATORY EXPERT REVIEW REQUIRED")
        print("!" * 50)
        sys.exit(1) # Fail the pipeline
    else:
        print("\n[Pass] Impact is within safe limits.")

if __name__ == "__main__":
    if len(sys.argv) > 1:
        spec_id = sys.argv[1]
    else:
        spec_id = "SPEC-OB-FUNC"
        
    analyze_impact(spec_id)
