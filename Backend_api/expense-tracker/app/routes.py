from fastapi import APIRouter, Query
from app.models import Expense
from app.services import save_expense, get_summary

router = APIRouter()

@router.post("/expenses")
def add_expense(expense: Expense):
    save_expense(expense)
    return {"message": "Expense added successfully."}

@router.get("/expenses/summary")
def get_expense_summary(period: str = Query("monthly", enum=["daily", "weekly", "monthly"])):
    summary = get_summary(period)
    return summary
