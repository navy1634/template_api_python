from collections.abc import Generator

import pytest
from sqlalchemy import create_engine
from sqlalchemy.engine import Engine
from sqlalchemy.orm import Session, sessionmaker
from testcontainers.postgres import PostgresContainer


@pytest.fixture(scope="session")
def postgres_container() -> Generator[PostgresContainer]:
    with PostgresContainer("postgres:18.4") as container:
        yield container


@pytest.fixture(scope="session")
def db_engine(postgres_container: PostgresContainer) -> Generator[Engine]:
    engine = create_engine(postgres_container.get_connection_url())
    yield engine
    engine.dispose()


@pytest.fixture
def db_session(db_engine: Engine) -> Generator[Session]:
    factory = sessionmaker(bind=db_engine)
    session = factory()
    try:
        yield session
        session.rollback()
    finally:
        session.close()
