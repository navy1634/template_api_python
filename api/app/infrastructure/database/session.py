from sqlalchemy.exc import SQLAlchemyError

from app.infrastructure.database.get_db import ConnectDatabase

factory = ConnectDatabase()
db_session = factory.get_session()


def get_db():
    session = db_session()
    try:
        yield session
        session.commit()
    except SQLAlchemyError:
        session.rollback()
        raise
    finally:
        session.close()
