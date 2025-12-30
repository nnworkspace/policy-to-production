# artefact_type: implementation
# visibility: public
# audience: everyone
# form: source
# role: implementation
# status: informative
# owner: ci-cd-automation
# ------------------------------------------------------------------------------
# DISCLAIMER:
# This file is an ILLUSTRATIVE EXAMPLE of a Parser for the "Analytical Pipeline".
# It demonstrates the logic of extracting structured data from unstructured specs.
# ------------------------------------------------------------------------------

import re
import json
import sys
import os

class SpecParser:
    def __init__(self, filepath):
        self.filepath = filepath
        self.content = ""
        self.transitions = []
        self.requirements = []

    def load(self):
        with open(self.filepath, 'r') as f:
            self.content = f.read()

    def parse_transitions(self):
        """
        Parses the Markdown table for Transition Logic.
        Looks for lines starting with | and containing TR-OB-
        """
        lines = self.content.split('\n')
        for line in lines:
            if "| **TR-" in line or "| TR-" in line:
                parts = [p.strip() for p in line.split('|')]
                # parts[0] is empty, parts[1] is ID, etc.
                if len(parts) >= 7:
                    self.transitions.append({
                        "id": self._clean(parts[1]),
                        "from_state": self._clean(parts[2]),
                        "to_state": self._clean(parts[3]),
                        "trigger": self._clean(parts[4]),
                        "logic": self._clean(parts[5]),
                        "trace": self._clean(parts[6])
                    })

    def parse_requirements(self):
        """
        Parses Functional Requirements.
        Looks for bullet points starting with - **REQ-
        """
        regex = r'- \*\*(REQ-[A-Z]+-[A-Z]+-\d+):\*\* (.*)'
        matches = re.finditer(regex, self.content)
        for match in matches:
            self.requirements.append({
                "id": match.group(1),
                "statement": match.group(2)
            })

    def _clean(self, text):
        return text.replace('**', '').replace('`', '').strip()

    def to_json(self):
        return json.dumps({
            "source_file": os.path.basename(self.filepath),
            "transitions": self.transitions,
            "requirements": self.requirements
        }, indent=2)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python spec_parser.py <path_to_spec.md>")
        sys.exit(1)
    
    parser = SpecParser(sys.argv[1])
    parser.load()
    parser.parse_transitions()
    parser.parse_requirements()
    print(parser.to_json())
