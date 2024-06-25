# Use a imagem oficial do Python como imagem base
FROM python:3.9-slim

# Defina o diretório de trabalho no contêiner
WORKDIR /app

# Copie o arquivo requirements.txt para o diretório de trabalho
COPY requirements.txt .

# Instale as dependências do Python
RUN pip install --no-cache-dir -r requirements.txt

# Copie o restante do código da aplicação para o diretório de trabalho
COPY . .

# Exponha a porta em que o Django será executado (padrão 8000)
EXPOSE 8000

# Defina a variável de ambiente para desativar o buffering de saída do Python
ENV PYTHONUNBUFFERED=1

RUN python manage.py makemigrations

RUN python manage.py migrate
# Comando para rodar a aplicação Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
