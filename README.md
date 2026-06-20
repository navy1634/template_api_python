# template_api_python

FastAPI + Terraform を組み合わせた AWS デプロイ対応の API テンプレートです。

## ディレクトリ構成

```
.
├── api/           # FastAPI アプリケーション
├── terraform/     # AWS インフラ定義（Terraform）
├── .devcontainer/ # Dev Container 設定
├── .github/       # GitHub Actions ワークフロー・テンプレート
├── compose.yml    # ローカル開発用 Docker Compose
└── renovate.json  # 依存関係自動更新設定
```

## クイックスタート

### 前提条件

- Docker / Docker Compose

### ローカル起動

```bash
docker compose up
```

API は `http://localhost:3032` で起動します。PostgreSQL は `localhost:5432` で利用できます。

### 環境変数

| 変数名            | デフォルト値 | 説明                   |
| ----------------- | ------------ | ---------------------- |
| POSTGRES_DB       | pokemon      | データベース名         |
| POSTGRES_USER     | pokemon      | データベースユーザー   |
| POSTGRES_PASSWORD | password     | データベースパスワード |
| POSTGRES_HOST     | db           | データベースホスト     |
| POSTGRES_PORT     | 5432         | データベースポート     |

## 各コンポーネントの詳細

- [API](./api/README.md)
- [Terraform](./terraform/README.md)

## 依存関係の自動更新

Renovate により毎週月曜の午前9時前に PR が作成されます。minor/patch は自動マージされ、major は手動レビューが必要です。
