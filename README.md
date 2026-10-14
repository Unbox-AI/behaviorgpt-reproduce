# behaviorgpt-reproduce

Reproduce the BehaviorGPT benchmark results through the public API.

Each notebook rebuilds a benchmark split from the official public download, asks the hosted model for a ranking at every evaluated position through the [BehaviorGPT SDK](https://github.com/Unbox-AI/behaviorgpt), and computes the metrics from the returned rankings.

| benchmark | notebook | preprocessing |
|---|---|---|
| [PixelRec](https://github.com/westlake-repl/PixelRec) | [`notebooks/pixelrec.ipynb`](notebooks/pixelrec.ipynb) | [`preprocessing/pixelrec.py`](preprocessing/pixelrec.py) |

## Requirements

- An Unbox AI API key. Create and copy the key at [unboxai.com/behaviorgpt](https://unboxai.com/behaviorgpt); the key also arrives by email.
- Python 3.11 or newer, and [uv](https://github.com/astral-sh/uv).

## Setup

Clone, install, add your key, start JupyterLab:

```sh
git clone https://github.com/Unbox-AI/behaviorgpt-reproduce.git
cd behaviorgpt-reproduce
uv sync
cp .env.example .env   # paste your key as UNBOXAI_API_KEY
uv run jupyter lab
```

JupyterLab opens in your browser, running in the repository's environment. In VS Code instead, open the repository folder and pick the `.venv` environment as the notebook's kernel.

## PixelRec

[`notebooks/pixelrec.ipynb`](notebooks/pixelrec.ipynb) reproduces the zero-shot PixelRec evaluation from our paper. It asks the model for a ranking at each of the 79,399 evaluated positions and computes recall, NDCG and MRR from the returned rankings. It ranks the hosted catalog `PixelRec200K`, so nothing is uploaded.

Download `Pixel200K.csv` from both the "Interaction" and the "Item Information" folders linked in the [PixelRec repository](https://github.com/westlake-repl/PixelRec), and place them as:

```
data/pixelrec/raw/interactions/Pixel200K.csv
data/pixelrec/raw/items/Pixel200K.csv
```

The notebook checks both files against the release the paper's numbers were measured on, runs [`preprocessing/pixelrec.py`](preprocessing/pixelrec.py) on them, then makes one API call per position, about an hour in all; it saves as it goes and resumes where it stopped. By default it scores a fixed random subset of 5,000 positions; set `MAX_CALLS = None` for the full run. It writes the benchmark split (about 115 MB) to `data/` and the rankings (about 95 MB for the full run) to `results/`, both ignored by git.

## Development

```sh
uv sync
make check   # ruff lint and format check
make test    # pytest
```

## License

MIT, see [LICENSE](LICENSE).
