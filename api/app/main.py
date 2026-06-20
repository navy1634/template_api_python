from fastapi import FastAPI, Request, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse

from app.endpoint.route import router
from app.infrastructure.error import DomainBaseError
from app.usecase.error import ApplicationBaseError

app = FastAPI()

origins = ["*", "127.0.0.1"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(router, prefix="/api")


@app.exception_handler(DomainBaseError)
def exception_domain_error(request: Request, exc: DomainBaseError) -> JSONResponse:
    return JSONResponse(
        status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
        content={"message": exc.msg},
    )


@app.exception_handler(ApplicationBaseError)
def exception_application_error(request: Request, exc: ApplicationBaseError) -> JSONResponse:
    return JSONResponse(
        status_code=status.HTTP_400_BAD_REQUEST,
        content={"message": exc.msg},
    )
