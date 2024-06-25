## Como rodar o projeto
1. 

    - Criar e ativar ambiente virtual
        ```sh
        python3 -m venv venv
        source venv/bin/activate
        ```
    - Instalação pip - se necessário
        ```sh
        sudo apt update
        sudo apt install python3-pip
        pip3 --version
        ```

    - instalando dependencias
        ```sh
        pip install -r requirements.txt
        ```
    ---

2. 
    - [Documentação dockerhub](https://hub.docker.com/_/postgres)
        - Baixar imagem POSTGRESQL

            ```bash
            docker pull postgres
            ```
        
        - Cria container 
        Nomeando `--name fusion-postgres` 
        Adiciono informação da porta `-p 5432:5432`
        Informo a senha `POSTGRES_PASSWORD=suasenha`
        
        ```bash
        docker run -p 5432:5432 --name fusion-postgres -e POSTGRES_PASSWORD=suasenha -d postgres

        ```
        
        - Iniciar container
        
            ```bash
            docker start fusion-postgres
            ```
        
        - Verificar `id` container e `ip` do container
        
            ```bash
            sudo docker ps
            sudo docker container inspect idcontainer
            ```

        - Acessar container no modo interativo - container em execução
            >Criação database e usuário
        
            ```bash
            sudo docker exec -it idcontainer bash
            ```
            - Acessando postgres `database` com usuário `postgres`
        
                ```bash
                psql -U postgres
                ```
        
            - Criar database
        
                ```bash
                create database "fusion";
                ```
        
            -  Criar usuário no postgres
        
                ```bash
                create user cristiano superuser inherit createdb createrole password 'surasenha';
                ```

            - Saindo do postgres
        
                ```bash
                \q
                ```
        
            - Acessando database `fusion`. Use o  `ip` do container
                >Comandos válidos
        
                ```bash
                psql -U postgres -d fusion
                psql ipcontainer -U postgres -d fusion

                psql -h ipcontainer -U postgres -d fusion
                ```
        
            - Listando database
        
                ```bash
                \l
                ```
        
            - Sair do container
        
                ```bash
                exit
                ```

    ---

# Criando conexão com banco de dados

- Criar app no mesmo diretório/pasta que está o projeto.
    >Criar arquivo `privateData.py` com dicionário de dados `myData` contendo as informaçoes que não quero que vá para repositório - Então incluirei o arquivo com a classe no gitignore
  
        Dicinário `myData`
        
        ```python
        myData = {
            'SENHA_PSTGRESQL': '',
            'USUARIO_POSTGRESQL': '',
            'SECRET_SETTINGS': '',
            'POSTGRESQL_DB_NAME': '',
            'HOST': '',
        }
        ```

        ```

- Executar `migrations` e `migrate` 
            
        ```bash
        python manage.py makemigrations
        python manage.py migrate
        ```

- Criar super `usuário django`
            
        ```bash
        python manage.py createsuperuser
        ```
---

## Rodando testes
        ```bash
        sudo docker start fusion-postgres
        coverage run manage.py test
        coverage html
        cd htmlcov
        python -m http.server
        ```