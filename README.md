# docker-rails
dockerfile para gerar uma imagem com rails instalado e docker-compose  para rodar os serviços

#para gerar a imagem
docker build -t nomeimagem .

#para iniciar o docker
docker-compose up -d

#conectarno container
ssh app@localhost -p 2222
