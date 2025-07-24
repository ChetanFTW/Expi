import json
from pathlib import Path
from datetime import datetime, timedelta
from typing import List
from app.models import Expense

DB_FILE = Path("app/database.json")

def load_expenses() -> List[Expense]:
    if not DB_FILE.exists():
        return []
    with open(DB_FILE, "r") as f:
        data = json.load(f)
    return [Expense(**item) for item in data]

#def save_expense(expense: Expense):
    #expenses = load_expenses()
    #expenses.append(expense)
    #with open(DB_FILE, "w") as f:
  #      json.dump([e.dict() for e in expenses], f, indent=4)
#	json.dump([{
 #   		**e.dict(),
  #  		"date": e.date.isoformat()
   #         	} for e in expenses], f, indent=4)

def save_expense(expense: Expense):
    expenses = load_expenses()
    expenses.append(expense)
    with open(DB_FILE, "w") as f:
        json.dump([{
            **e.dict(),
            "date": e.date.isoformat()
        } for e in expenses], f, indent=4)


def get_summary(period: str):
    expenses = load_expenses()
    now = datetime.now()
    
    if period == "daily":
        filtered = [e for e in expenses if e.date == now.date()]
    elif period == "weekly":
        start = now - timedelta(days=7)
        filtered = [e for e in expenses if datetime.strptime(str(e.date), "%Y-%m-%d") >= start]
    elif period == "monthly":
        start = now.replace(day=1)
        filtered = [e for e in expenses if datetime.strptime(str(e.date), "%Y-%m-%d") >= start]
    else:
        filtered = expenses

    return filtered
