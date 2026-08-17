import os

from sqlalchemy import create_engine
from sqlalchemy.engine import URL
from sqlalchemy.orm import Session, sessionmaker

DEFAULT_DATABASE_PORT = 5432


class ConnectDatabase:
    def __init__(self) -> None:
        # データベース設定
        self.database_url = self.get_database_url()
        self.engine = create_engine(self.database_url, echo=True, future=True)
        self.session = sessionmaker(autocommit=False, autoflush=True, bind=self.engine)

    def get_session(self) -> sessionmaker[Session]:
        return self.session

    def get_database_url(self) -> URL:
        """環境変数からデータベース接続 URL を生成する。

        Returns:
            SQLAlchemy が利用するデータベース接続 URL。

        Raises:
            KeyError: 必須の環境変数が設定されていない場合。
            ValueError: ポート番号が整数に変換できない場合。
        """
        return URL.create(
            drivername="postgresql+psycopg2",
            username=os.environ["DATABASE_USER"],
            password=os.environ["DATABASE_PASSWORD"],
            host=os.environ["DATABASE_HOST"],
            port=int(os.getenv("DATABASE_PORT", str(DEFAULT_DATABASE_PORT))),
            database=os.environ["DATABASE_NAME"],
        )
