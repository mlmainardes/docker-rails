# docker-rails <br>
dockerfile para gerar uma imagem com rails instalado e docker-compose  para rodar os serviços

#para gerar a imagem <br>
docker build -t nomeimagem .

#para iniciar o docker <br>
docker-compose up -d

#conectarno container <br>
ssh app@localhost -p 2222
