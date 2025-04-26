# Usa a imagem base do Ubuntu
FROM ubuntu

# Expõe a porta 80 (útil para servidores web como o nginx)
EXPOSE 80

# Cria um usuário chamado "leonardodutra"
RUN useradd leonardodutra

# Atualiza os pacotes e instala o curl e o nginx
RUN apt update && apt install -y curl && apt install nginx -y

# Define uma variável de build-time chamada VAR_TEXT (valor padrão "Minha var texto")
ARG VAR_TEXT="Minha var texto"

# Define o diretório de trabalho dentro do container para /app
WORKDIR /app

# Cria um arquivo arg.txt contendo o valor da variável de build-time VAR_TEXT
RUN echo $VAR_TEXT > arg.txt

# Adiciona metadados de contato para a imagem
LABEL contato="meuemail@hotmail.com"
# Adiciona um label de versão para a imagem
LABEL versao="1.0"

# Define uma variável de ambiente VALOR_DOCKER_ENV disponível no runtime
ENV VALOR_DOCKER_ENV="Valor XPTO"

# Copia o arquivo "arquivo.txt" para o diretório de trabalho /app,
# atribuindo a propriedade para o usuário "leonardodutra" e permissões 777 (total acesso)
COPY --chown=leonardodutra:leonardodutra --chmod=777 arquivo.txt ./

# Descompacta o arquivo "teste.tar.gz" para o diretório de trabalho /app
ADD teste.tar.gz ./

# Declara que o diretório /app será um volume (ponto de montagem externo)
VOLUME /app

# Define que o usuário padrão do container será "leonardodutra"
USER leonardodutra

# Copia o script de entrada "entrypoint.sh" para o container
# com propriedade para "leonardodutra" e permissões 755 (execução)
COPY --chown=leonardodutra:leonardodutra --chmod=755 entrypoint.sh ./

# Define o ponto de entrada do container como o script entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]

# Define o comando padrão que será passado como argumento para o entrypoint (caso nada seja passado)
CMD ["XPTO"]