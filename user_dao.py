import bcrypt
from db.connection import get_connection

class UserDAO:
    def __init__(self):
        self.conn = None
    def _get_connection(self):
        if self.conn is None or not self.conn.is_connected():
            self.conn = get_connection()
        return self.conn

    def create_user(self, email, password):
        try:
            conn = self._get_connection()
            cursor = conn.cursor()

            password_hash = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())
            query = "insert into users (email, password_hash) values (%s, %s)"
            cursor.execute(query, (email, password_hash))

            user_id = cursor.lastrowid
            cursor.close()
            return user_id
        except Exception as e:
            if "Duplicate entry" in str(e):
                return None
            raise e
    def authenticate_user(self, email, password):
        try:
            conn = self._get_connection()
            cursor = conn.cursor()

            query = "select id, password_hash from users where email = %s"
            cursor.execute(query, (email,))
            result = cursor.fetchone()
            cursor.close()
            if result is None:
                return None
            user_id, stored_hash = result
            if bcrypt.checkpw(password.encode('utf-8'), stored_hash.encode('utf-8')):
                return user_id
            return None
        except Exception as e:
            raise e
