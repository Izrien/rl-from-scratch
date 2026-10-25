# rl-from-scratch

Reinforcement learning from first principles: neural networks (`src/nn`), tabular methods (`src/tabular`) and DQN (`src/dqn`).

- Setup (Python 3.11): `pip install torch==2.14.1 --index-url https://download.pytorch.org/whl/cpu`, then `pip install -e ".[dev]"` and `pre-commit install`.
- Checks, as CI runs them: `ruff check . && ruff format --check . && mypy src && pytest tests/ -q`.
- What blocked me and how I got past it: [docs/learning-log.md](docs/learning-log.md).
