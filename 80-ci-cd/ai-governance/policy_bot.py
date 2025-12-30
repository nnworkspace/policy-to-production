# artefact_type: implementation
# visibility: public
# audience: everyone
# form: source
# role: implementation
# status: informative
# owner: ci-cd-automation
# ------------------------------------------------------------------------------
# DISCLAIMER:
# This file is an ILLUSTRATIVE EXAMPLE of a "Policy Bot" (RAG Interface).
# It simulates retrieval-augmented generation for compliance queries.
# ------------------------------------------------------------------------------

import json
import sys
import argparse

KNOWLEDGE_FILE = "80-ci-cd/ai-governance/knowledge_base.json"

def load_knowledge():
    try:
        with open(KNOWLEDGE_FILE, "r") as f:
            return json.load(f)
    except FileNotFoundError:
        print(f"[Error] Knowledge Base not found. Run knowledge_indexer.py first.")
        sys.exit(1)

def query_bot(query, knowledge_db):
    print(f"\n[Bot] analyzing query: '{query}'...")
    
    # Simple Keyword Matching (Mocking Vector Similarity)
    keywords = set(query.lower().split())
    results = []
    
    for chunk in knowledge_db:
        # Check if chunk has text field
        if "text" not in chunk: continue
        
        text = chunk["text"].lower()
        score = sum(1 for k in keywords if k in text)
        if score > 0:
            results.append((score, chunk))
    
    # Sort by score
    results.sort(key=lambda x: x[0], reverse=True)
    top_results = results[:3]
    
    if not top_results:
        print("[Bot] I cannot find any specific policy regarding that.")
        return

    print(f"[Bot] I found {len(top_results)} relevant governance excerpts:\n")
    
    for score, chunk in top_results:
        print(f"--- SOURCE: {chunk['source']} (Section: {chunk['section']}) ---")
        # Print a snippet
        snippet = chunk['text'][:200].replace('\n', ' ') + "..."
        print(f"\"{snippet}\"")
        print(f"[Relevance Score: {score}]\n")

    print("[Bot] ADVICE: Based on the above, please ensure you satisfy the stated constraints.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Eurosystem Governance Oracle")
    parser.add_argument("query", nargs="+", help="The compliance question to ask")
    args = parser.parse_args()
    
    query_text = " ".join(args.query)
    db = load_knowledge()
    query_bot(query_text, db)
