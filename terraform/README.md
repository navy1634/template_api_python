# terraform

AWS 上に ECS（Fargate）+ RDS + ALB 構成をプロビジョニングする Terraform テンプレート

## 技術スタック

| カテゴリ       | 採用技術                 |
| -------------- | ------------------------ |
| IaC            | Terraform                |
| Linter         | TFLint                   |
| ドキュメント生成 | terraform-docs          |
| プラン通知     | tfcmt                    |
| クラウド       | AWS（ap-northeast-1）    |

## ディレクトリ構成

```
terraform/
├── env/
│   ├── dev/   # 開発環境
│   └── prd/   # 本番環境
└── modules/
    ├── vpc/       # VPC・サブネット・ゲートウェイ
    ├── cluster/   # ECS クラスター・ALB・IAM
    ├── container/ # ECS タスク定義・ECR・ロードバランサーリスナー
    └── database/  # RDS（PostgreSQL）
```

## インフラ構成

```
Internet
    │
    ▼
ALB（Public Subnet: 1a / 1c / 1d）
    │
    ▼
ECS Fargate（Private Subnet: 1a / 1c / 1d）
    │
    ▼
RDS PostgreSQL（Private Subnet）
```

## 開発コマンド

```bash
cd terraform/env/dev   # または prd

# 初期化
terraform init

# フォーマット
terraform fmt

# 検証
terraform validate

# Lint
tflint --config=$(pwd)/../../.tflint.hcl --recursive

# プラン
terraform plan

# 適用
terraform apply
```

## Secrets Manager

DB 認証情報は AWS Secrets Manager から取得します。`rds/template/secrets` というシークレット名で `username` / `password` キーを持つ JSON を事前に登録してください。
