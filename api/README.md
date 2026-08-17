# API

FastAPI + PostgreSQL + SQLAlchemy で構成されたバックエンド API テンプレート

## 技術スタック

| カテゴリ       | 採用技術                      |
| -------------- | ----------------------------- |
| フレームワーク | FastAPI                       |
| DB ドライバー  | psycopg2                      |
| ORM            | SQLAlchemy                    |
| サーバー       | Uvicorn                       |
| パッケージ管理 | uv                            |
| Linter         | ruff                          |
| 型検査         | mypy (strict)                 |
| テスト         | pytest + testcontainers       |

## ディレクトリ構成

```
api/
├── app/
│   ├── domain/
│   │   ├── entity/        # ドメインエンティティ
│   │   ├── repository/    # リポジトリインターフェース
│   │   └── value_object/  # 値オブジェクト
│   ├── endpoint/
│   │   ├── router/        # ルーター定義
│   │   ├── schema/        # リクエスト・レスポンススキーマ
│   │   └── route.py       # ルート登録
│   ├── infrastructure/
│   │   ├── database/      # DB 接続・セッション管理
│   │   ├── error/         # ドメイン例外
│   │   ├── models/        # SQLAlchemy モデル
│   │   └── repository/    # リポジトリ実装
│   ├── usecase/
│   │   └── error/         # ユースケース例外
│   └── main.py            # アプリケーションエントリーポイント
├── tests/
│   ├── domain/            # ドメイン層テスト
│   ├── endpoint/          # エンドポイントテスト
│   ├── infrastructure/    # インフラ層テスト
│   ├── integration/       # 統合テスト
│   └── usecase/           # ユースケーステスト
├── Dockerfile
└── pyproject.toml
```

## 開発環境のセットアップ

### 前提条件

- uv

### 依存関係のインストール

```sh
cd api
uv sync
```

### 開発サーバーの起動

```sh
uv run task dev
```

API は `http://localhost:80` で起動します。

### 環境変数

| 変数名            | 説明                   |
| ----------------- | ---------------------- |
| DATABASE_USER     | データベースユーザー   |
| DATABASE_PASSWORD | データベースパスワード |
| DATABASE_HOST     | データベースホスト     |
| DATABASE_NAME     | データベース名         |

## 開発コマンド

```sh
# 依存パッケージのインストール
uv sync

# Lint（自動修正あり）
uv run task lint

# フォーマット
uv run task format

# 型検査
uv run task type-check

# テスト
uv run task test
```

## ローカル開発のデータベース migration

以下は `compose.yml` で起動した PostgreSQL に対する、ローカル開発用の手順です。本番環境の migration 実行経路はこのリポジトリでは定義していません。

Alembic は `compose.yml` の `DATABASE_*` 環境変数を使って PostgreSQL に接続します。

```sh
docker compose up -d db
```

モデルを追加した後、migration ファイルを作成して適用します。

```sh
docker compose run --rm api uv run task migration-revision -- "変更内容"
docker compose run --rm api uv run task migration-upgrade
```

現在の適用状況を確認したり、直前の migration を戻したりできます。

```sh
docker compose run --rm api uv run task migration-current
docker compose run --rm api uv run task migration-downgrade
```

## エンドポイント

| メソッド | パス          | 説明           |
| -------- | ------------- | -------------- |
| GET      | /api/health   | ヘルスチェック |

## アーキテクチャ

クリーンアーキテクチャの4層構成を採用しています。

```
endpoint（Controller）
    ↓
usecase（Application）
    ↓
domain（Business Logic）
    ↑
infrastructure（DB・外部連携）
```

- **endpoint**: HTTP リクエストの受付とレスポンス返却
- **usecase**: ビジネスロジックのオーケストレーション
- **domain**: エンティティ・値オブジェクト・リポジトリインターフェース
- **infrastructure**: DB 接続・ORM モデル・リポジトリ実装

例外はドメイン例外（`DomainBaseError`）とユースケース例外（`ApplicationBaseError`）の2種に分類され、`main.py` のハンドラーでそれぞれ HTTP 500 / 400 に変換されます。
