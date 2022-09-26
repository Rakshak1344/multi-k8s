docker build -t rakshak1344/multi-client:latest -t rakshak1344/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rakshak1344/multi-server:latest -t rakshak1344/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rakshak1344/multi-worker:latest -t rakshak1344/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rakshak1344/multi-client:latest
docker push rakshak1344/multi-server:latest
docker push rakshak1344/multi-worker:latest

docker push rakshak1344/multi-client:$SHA
docker push rakshak1344/multi-server:$SHA
docker push rakshak1344/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rakshak1344/multi-server:$SHA
kubectl set image deployments/client-deployment client=rakshak1344/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rakshak1344/multi-worker:$SHA