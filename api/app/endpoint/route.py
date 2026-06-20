from fastapi import APIRouter, status

router = APIRouter()


@router.get("/health", response_model=dict[str, str], status_code=status.HTTP_200_OK)
def index() -> dict[str, str]:
    """status check

    Args:
        db (Session, optional): db connection. Defaults to Depends(get_db).

    Returns:
        dict: status ok
    """
    return {"status": "ok"}
