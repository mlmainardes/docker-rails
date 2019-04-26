# docker-rails \r
dockerfile para gerar uma imagem com rails instalado e docker-compose  para rodar os serviços

#para gerar a imagem \r
docker build -t nomeimagem .

#para iniciar o docker \r
docker-compose up -d

#conectarno container \r
ssh app@localhost -p 2222
