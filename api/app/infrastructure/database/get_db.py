import os

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker


class ConnectDatabase:
    def __init__(self) -> None:
        # データベース設定
        DATABASE_USER = os.getenv("DATABASE_USER")
        DATABASE_PASSWORD = os.getenv("DATABASE_PASSWORD")
        DATABASE_HOST = os.getenv("DATABASE_HOST")
        DATABASE_NAME = os.getenv("DATABASE_NAME")
        DATABASE_URL = f"postgresql+psycopg2://{DATABASE_USER}:{DATABASE_PASSWORD}@{DATABASE_HOST}:5432/{DATABASE_NAME}"
        self.engine = create_engine(DATABASE_URL)
        self.session = sessionmaker(autocommit=False, autoflush=True, bind=self.engine)

    def get_session(self):
        return self.session
