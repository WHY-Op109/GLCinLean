#!/usr/bin/env python3
"""Fetch the papers pinned in references/papers/manifest.toml (D6).

Downloads each entry's arXiv source (e-print) and PDF at the pinned version into the git-ignored
folder references/papers/<id>v<version>/, checks the SHA-256 checksums recorded in the manifest,
and unpacks the source into src/. The papers are never committed to any repository (D6).

Usage (from the repository root; Python 3.11+, standard library only):
    python3 -I scripts/fetch-papers.py            # fetch what is missing, verify everything
    python3 -I scripts/fetch-papers.py --only 2405.03599
    python3 -I scripts/fetch-papers.py --print-checksums   # TOML lines for unpinned entries

Polite use of arXiv (D6): one request at a time, a pause between requests, a generic
User-Agent, and no request for a file that is already present and verified.
"""
import argparse, gzip, hashlib, io, pathlib, sys, tarfile, time, tomllib, urllib.request

ROOT = pathlib.Path(__file__).resolve().parent.parent
MANIFEST = ROOT / "references" / "papers" / "manifest.toml"
OUT = ROOT / "references" / "papers"
PAUSE = 3.0
UA = "GLCinLean-fetch-papers/0 (python-urllib)"

def sha256(path):
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()

def download(url, dest):
    req = urllib.request.Request(url, headers={"User-Agent": UA})
    with urllib.request.urlopen(req, timeout=120) as r:
        data = r.read()
    tmp = dest.with_suffix(dest.suffix + ".part")
    tmp.write_bytes(data)
    tmp.replace(dest)
    time.sleep(PAUSE)

def unpack(src, dest):
    """arXiv e-prints are a gzipped tar, or a single gzipped .tex file."""
    dest.mkdir(parents=True, exist_ok=True)
    raw = src.read_bytes()
    try:
        with tarfile.open(fileobj=io.BytesIO(raw), mode="r:*") as t:
            t.extractall(dest, filter="data")   # refuses absolute paths and '..' (untrusted data)
            return
    except tarfile.ReadError:
        pass
    (dest / "main.tex").write_bytes(gzip.decompress(raw))

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--only", action="append", default=[], help="arXiv id to fetch (repeatable)")
    ap.add_argument("--print-checksums", action="store_true")
    args = ap.parse_args()
    manifest = tomllib.loads(MANIFEST.read_text())
    if manifest.get("format") != "glcinlean-papers/0":
        sys.exit(f"{MANIFEST}: unsupported format")
    failures = 0
    for p in manifest["paper"]:
        pid, v = p["arxiv"], p["version"]
        if args.only and pid not in args.only:
            continue
        tag = f"{pid}v{v}"
        d = OUT / tag
        d.mkdir(parents=True, exist_ok=True)
        files = {"source": (f"https://arxiv.org/e-print/{tag}", d / f"{tag}.source.gz"),
                 "pdf": (f"https://arxiv.org/pdf/{tag}", d / f"{tag}.pdf")}
        for kind, (url, dest) in files.items():
            want = p.get(f"sha256_{kind}", "")
            if not (dest.exists() and (not want or sha256(dest) == want)):
                print(f"fetch {url}")
                download(url, dest)
            got = sha256(dest)
            if want and got != want:
                print(f"MISMATCH {tag} {kind}: manifest {want}, file {got}", file=sys.stderr)
                failures += 1
            elif not want:
                print(f"unpinned {tag} {kind}: {got}")
            if args.print_checksums:
                print(f'# {tag}\nsha256_{kind} = "{got}"')
        if not (d / "src").exists():
            unpack(files["source"][1], d / "src")
        print(f"ok {tag}: {p['title']}")
    sys.exit(1 if failures else 0)

if __name__ == "__main__":
    main()
