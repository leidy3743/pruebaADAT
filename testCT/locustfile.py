from locust import HttpUser, task, between
from bs4 import BeautifulSoup

class WebsiteUser(HttpUser):
    wait_time = between(1, 3)

    def on_start(self):
        # Intentar obtener CSRF si usas Flask-WTF (no parece en login.html, pero manejamos ambos casos)
        r = self.client.get("/login")
        csrf_token = None
        try:
            soup = BeautifulSoup(r.text, 'html.parser')
            csrf_input = soup.find('input', {'name': 'csrf_token'})
            if csrf_input:
                csrf_token = csrf_input.get('value')
        except Exception:
            pass

        payload = {
            'username': 'user1',
            'password': 'pass1',
        }
        if csrf_token:
            payload['csrf_token'] = csrf_token

        self.client.post("/login", data=payload, allow_redirects=True)

    @task(2)
    def dashboard(self):
        self.client.get("/dashboard")

    @task(2)
    def quiz4(self):
        self.client.get("/quiz4")

    @task(1)
    def logout(self):
        self.client.get("/logout")
