import requests
from flask import Flask, jsonify, request, render_template

app = Flask(__name__)

def backend_available():
    try:
        response = requests.get('http://backend:8080/up')
        if response.status_code == 200 and response.json().get('status') == 'up':
            print(f"Connected to Backend server")
            return True
        else:
            print(f"Backend is not up. Status code: {response.status_code}, Response: {response.json()}")
            return False
    except requests.exceptions.RequestException as e:
        print(f"Failed to connect to backend: {e}")
        return False

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/members', methods=['GET'])
def get_members():
    # Заглушка: Возвращаем список членов кооператива
    return jsonify([
        {"id": 1, "name": "Иван Иванов", "share": 1000},
        {"id": 2, "name": "Анна Петрова", "share": 2000},
    ])

@app.route('/api/transactions', methods=['GET'])
def get_transactions():
    # Заглушка: Возвращаем список транзакций
    return jsonify([
        {"id": 1, "member_id": 1, "type": "взнос", "amount": 500},
        {"id": 2, "member_id": 2, "type": "вывод", "amount": 300},
    ])

@app.route('/api/transactions', methods=['POST'])
def add_transaction():
    # Заглушка: Обрабатываем добавление новой транзакции
    data = request.json
    # TODO: Здесь должна быть логика для добавления транзакции в базу данных
    return jsonify({"status": "success", "message": "Transaction added", "data": data})

@app.route('/api/members', methods=['POST'])
def add_member():
    # Заглушка: Обрабатываем добавление нового члена кооператива
    data = request.json
    # TODO: Здесь должна быть логика для добавления нового члена в базу данных
    return jsonify({"status": "success", "message": "Member added", "data": data})

@app.route('/api/report', methods=['GET'])
def get_report():
    # Заглушка: Генерация финансового отчета
    # TODO: Здесь должна быть логика для подсчета и анализа данных
    report = {
        "total_shares": 3000,
        "total_contributions": 500,
        "total_withdrawals": 300
    }
    return jsonify(report)

if __name__ == '__main__':
    if backend_available():
        app.run(debug=True, host='0.0.0.0')
    else:
        print("Backend is not available. Exiting...")