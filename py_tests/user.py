import json, requests

base_url = 'http://127.0.0.1:4000'

def create_user(email, pwd):
    url = base_url + "/api/users"
    payload = {'user': {'email': email, 'password': pwd}}
    headers = {'content-type': 'application/json'}

    response = requests.post(url, data=json.dumps(payload), headers=headers)
    print(response.content)

def create_session(email, pwd):
    url = base_url + "/api/sessions"
    payload = {'user': {'email': email, 'password': pwd}}
    headers = {'content-type': 'application/json'}

    response = requests.post(url, data=json.dumps(payload), headers=headers)
    print(response.status_code)
    j = json.loads(response.text)
    return j['data']['token']

def get_todos(token):
    url = base_url + "/api/todos"
    headers = {'authorization': 'Token token='+token}
    response = requests.get(url, headers=headers)
    print(response.content)
        
def create_todo_ja(token, desc):        
    url = base_url + "/api/todos"
    payload = {'todo': {'description':desc}, 'token': token}
    headers = {'content-type':  'application/json'}

    response = requests.post(url, data=json.dumps(payload), headers=headers)
    print(response.text)

def create_todo(token, desc):        
    url = base_url + "/api/todos"
    payload = {'todo': {'description':desc}}
    headers = {
        'content-type':  'application/json',
        'authorization': 'Token token='+token
    }

    response = requests.post(url, data=json.dumps(payload), headers=headers)
    print(response.text)

def get_todo(token, tid):
    url = base_url + "/api/todos/" + str(tid)
    headers = {'authorization': 'Token token='+token}
    response = requests.get(url, headers=headers)

    response = requests.get(url, headers=headers)
    print(response.text)

def update_todo(token, tid, desc):
    url = base_url + "/api/todos/" + str(tid)
    payload = {'todo': {'description':desc}, 'token': token}
    headers = {'content-type':  'application/json'}

    response = requests.put(url, data=json.dumps(payload), headers=headers)
    print(response.text)

def del_todo(token, tid):
    url = base_url + "/api/todos/" + str(tid)
    headers = {'authorization': 'Token token='+token}
    response = requests.delete(url, headers=headers)

    response = requests.get(url, headers=headers)
    print(response.text)
    

#create_user('mkh@mail.ru', '123456')
token = create_session('mkh@mail.ru', '123456')
#token = 'fiJf2f8n1AF6DjULOw1H2g'
print("TOKEN: %s" % token)
get_todos(token)
#get_todo(token, 3)
#update_todo(token, 3, "llllll7676767676")
#get_todo(token, 3)
#create_todo_ja(token, "lalalalala22")
#del_todo(token, 3)
#get_todos(token)


