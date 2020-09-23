# 7. Build all our images, tag each one, push each other to docker hub - Start
# 7.1 Building images, and tagging - start
docker build -t kaushlendra277/multi-client:latest -t kaushlendra277/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kaushlendra277/multi-server:latest -t kaushlendra277/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kaushlendra277/multi-worker:latest -t kaushlendra277/multi-worker:$SHA -f ./worker/Dockerfile ./worker
# 7.1 Building images, and tagging - - end

# 7.2 push each other to docker hub - start
# To push docker images create kaushlendra277/multi-client in docker hub first
echo "pushing multi-client"
docker push kaushlendra277/multi-client:latest
docker push kaushlendra277/multi-client:$SHA
echo "pushing multi-server"
docker push kaushlendra277/multi-server:latest
docker push kaushlendra277/multi-server:$SHA
echo "pushing multi-worker"
docker push kaushlendra277/multi-worker:latest
docker push kaushlendra277/multi-worker:$SHA
# 7.2 push each other to docker hub - end
# 7. Build all our images, tag each one, push each other to docker hub - end

# 8. Apply all configs in the 'k8s' folder - Start
kubectl apply -f k8s
# 8. Apply all configs in the 'k8s' folder - end

# 9. Imperatively set latest images on each deployment - Start
kubectl set image deployments/client-deployment client=kaushlendra277/multi-client:$SHA
kubectl set image deployments/server-deployment server=kaushlendra277/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=kaushlendra277/multi-worker:$SHA
# 9. Imperatively set latest images on each deployment - end