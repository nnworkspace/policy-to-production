# artefact_type: implementation
# visibility: public
# audience: everyone
# form: source
# role: implementation
# status: informative
# owner: ci-cd-automation
# ------------------------------------------------------------------------------
# DISCLAIMER:
# This file is an ILLUSTRATIVE EXAMPLE of a "Knowledge Indexer" for RAG.
# It builds a simple keyword-based index from project specifications.
# ------------------------------------------------------------------------------

import os
import json
import glob

KNOWLEDGE_PATHS = [
    "20-rulebook/*.md",
    "30-architecture/*.md",
    "40-specifications/**/*.md"
]

OUTPUT_FILE = "80-ci-cd/ai-governance/knowledge_base.json"

def scan_repository():
    """
    Scans the defined paths and chunks Markdown files by header.
    """
    knowledge_db = []
    
    print(f"[Indexer] Scanning repository for Knowledge...")
    
    for pattern in KNOWLEDGE_PATHS:
        # Recursive glob if ** is in pattern
        recursive = "**" in pattern
        files = glob.glob(pattern, recursive=recursive)
        
        for file_path in files:
            if os.path.isdir(file_path): continue
            
            print(f"  - Indexing: {file_path}")
            with open(file_path, "r", encoding="utf-8") as f:
                content = f.read()
                chunks = chunk_markdown(content, file_path)
                knowledge_db.extend(chunks)

    print(f"[Indexer] Indexed {len(knowledge_db)} chunks.")
    return knowledge_db

def chunk_markdown(content, source):
    """
    Simple heuristic: Split by markdown headers (#)
    """
    chunks = []
    lines = content.split('\n')
    current_chunk = []
    current_header = "Intro"
    
    for line in lines:
        if line.startswith("#"):
            # Save previous chunk
            if current_chunk:
                chunks.append({
                    "source": source,
                    "section": current_header,
                    "text": "\n".join(current_chunk)
                })
            # Start new chunk
            current_header = line.strip("# ").strip()
            current_chunk = []
        else:
            current_chunk.append(line)
            
    # Save last chunk
    if current_chunk:
         chunks.append({
            "source": source,
            "section": current_header,
            "text": "\n".join(current_chunk)
        })
        
    return chunks

def save_index(db):
    try:
        with open(OUTPUT_FILE, "w") as f:
            json.dump(db, f, indent=2)
        print(f"[Indexer] Knowledge Base saved to {OUTPUT_FILE}")
    except OSError as e:
        print(f"[Error] Failed to save index: {e}")

if __name__ == "__main__":
    db = scan_repository()
    save_index(db)
