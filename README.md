# shvirtd-example-python

Example Flask-application for docker compose training.
## Installation
First, you need to clone this repository:

```bash
git clone https://github.com/netology-code/shvirtd-example-python.git
```

Now, we will need to create a virtual environment and install all the dependencies:

```bash
python3 -m venv venv  # on Windows, use "python -m venv venv" instead
. venv/bin/activate   # on Windows, use "venv\Scripts\activate" instead
pip install -r requirements.txt
python main.py
```
You need to run Mysql database and provide following ENV-variables for connection:  
- DB_HOST (default: '127.0.0.1')
- DB_USER (default: 'app')
- DB_PASSWORD (default: 'very_strong')
- DB_NAME (default: 'example')

The applications will always running on http://localhost:5000.  
To exit venv just type ```deactivate```

## License

This project is licensed under the MIT License (see the `LICENSE` file for details).

# Решение:
``` Если вам понадобилось внести иные изменения в проект - вы что-то делаете неверно!```
1. Не смог придержаться и внес 2 изменения:
    - Добавил в main.py load_dotenv для запуска из под виртуальной среды пайтон
    - Добавил DB_HOST в .env

    ![1.png](screenshots%2F1.png)

2. Добавил mysql.yaml для запуска mysql в контейнере для 1 задачи

    ![2.png](screenshots%2F2.png)

3. Задание 1: Запускаю dockerfile во втором задание вот так, предварительно запустив mysql в контейнере:
    - docker build -t my-python-app -f Dockerfile.python .
    - docker run -d --env-file .env -p 5000:5000 --network app-network --name my-running-app my-python-app
   
    ![3.png](screenshots%2F3.png)

    ![4.png](screenshots%2F4.png)

4. Задание 2.

    ![5.png](screenshots%2F5.png)

5. Задача 3. Так у меня и не заработало с ingress-proxy network_mode = host

    ![6.png](screenshots%2F6.png)

    Внес изменения в сервис ingress-proxy:
    ```
    ports:
      - 8090:8090
    networks:
      backend:
        ipv4_address: 172.20.0.33
    ```
    И в nginx default.conf:
    ```
    proxy_pass http://reverse-proxy:8080;
    ```
    После чего всё заработало.

    ![7.png](screenshots%2F7.png)

    ![8.png](screenshots%2F8.png)

    ![9.png](screenshots%2F9.png)

6. Задача 4. Запустил в облаке.

    [install.sh](install.sh)
	
	![10.png](screenshots%2F10.png)

	![11.png](screenshots%2F11.png)

	![12.png](screenshots%2F12.png)

7. Задача 5.

   [backup.sh](backup.sh)

   Попытался, но не получилось победить скрипт.

   Получаю ошибку при запуске:

   ```mysqldump: Got error: 2002: "Can't connect to server on '172.20.0.10' (115)" when trying to connect```
   
8. Задача 6.

   ![14.png](screenshots%2F14.png)
   
   ![15.png](screenshots%2F15.png)

   ![16.png](screenshots%2F16.png)

   ![17.png](screenshots%2F17.png)

   ![18.png](screenshots%2F18.png)

9. Задача 6.1

   ![13.png](screenshots%2F13.png)

10. Задача 6.2

    [Dockerfile.terraform](Dockerfile.terraform)
    
    Выполняем команду: ```docker build -t terraform-extract -f Dockerfile.terraform . > terraform.bin```
    Выполняется без ошибок, но файл весит 0 байт, ничего не смог придумать больше.
    Думал можно примонтировать общую директорию в контейнер и сделать cat в terraform.bin в ней в докерфайле в CMD, но run нельзя использовать, только build по условию.
   
    ![19.png](screenshots%2F19.png)
