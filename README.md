# django-avancado-postgresql

>Projeto Django Avançado com Bootstrap e PostgreSQL. Inclusão de testes.
> 
>>Projeto desenvolvido no curso da Geek University - Udemy [Programação Web com Python e Django Framework: Essencial](https://www.udemy.com/course/programacao-web-com-django-framework-do-basico-ao-avancado/)

## Ambiente de Desenvolvimento
Linux, Visual Studio Code, Docker e PostgreSQL

## Documentação
- [DJango](https://www.djangoproject.com/)
- Dica postgreSQL [vivaolinux](https://www.vivaolinux.com.br/artigo/psql-Conheca-o-basico)
- Tests [model_mommy](https://model-mommy.readthedocs.io/en/latest/basic_usage.html)
- Tests [coverage](https://coverage.readthedocs.io/en/7.3.2/)
- [Postgres dockerhub](https://hub.docker.com/_/postgres)


## Como rodar o projeto
1. <span style="color:383E42"><b>Preparando ambiente</b></span>
    <details><summary><span style="color:Chocolate">Detalhes</span></summary>
    <p>

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

    </p>

    </details> 

    ---

2. <span style="color:383E42"><b>Criar container fusion-postgres usando `POSTGRESQL` do `dockerhub`</b></span>
    <details><summary><span style="color:Chocolate">Detalhes</span></summary>
    <p>

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

3. <span style="color:383E42"><b>Criação de projeto `fusion` e app `core`</b></span>
    <details><summary><span style="color:Chocolate">Detalhes</span></summary>
    <p>
    
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
            >Para criação de arquivo de migração e criação das tabelas no banco
            ```bash
            python manage.py makemigrations
            python manage.py migrate
            ```

        - Criar super `usuário django`
            >Informar nome, email e senha
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