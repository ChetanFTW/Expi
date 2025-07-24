from fastapi import FastAPI
from app.routes import router

app = FastAPI(title="Expense Tracker API")
app.include_router(router)
