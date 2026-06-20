from collections.abc import Generator

from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.orm import Session

from app.infrastructure.database.get_db import ConnectDatabase

factory = ConnectDatabase()
db_session = factory.get_session()


def get_db() -> Generator[Session]:
    session = db_session()
    try:
        yield session
        session.commit()
    except SQLAlchemyError:
        session.rollback()
        raise
    finally:
        session.close()
