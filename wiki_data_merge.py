# coding=utf8

import sys
import os
import json
from pathlib import Path
from tqdm import tqdm

def merge(in_dir, out_path):
    p = Path(in_dir) 
    with open(out_path, 'w') as _out:
        for f in tqdm(p.rglob('wiki_*')):
            in_ = f.open()
            for text in in_:
                text = text.strip()
                if len(text) > 0:
                    obj = json.loads(text)
                    raw_text = obj['text']
                    if len(raw_text) >= 127:
                        _out.write(text + "\n")
                        

if __name__ == '__main__':
    merge(sys.argv[1], sys.argv[2])



