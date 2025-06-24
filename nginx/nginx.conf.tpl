events {
    worker_connections 1024;
}

http {
    server {
        listen 80;

        #Model-service Swagger UI & JSON
        location = /model/apidocs {
            proxy_pass         http://$MODEL_SERVICE_HOST:$MODEL_PORT;
            proxy_set_header   Host               $host;
            proxy_set_header   X-Real-IP          $remote_addr;
            proxy_set_header   X-Forwarded-For    $proxy_add_x_forwarded_for;
        }
        location ~ ^/model/flasgger_static/ {
            proxy_pass         http://$MODEL_SERVICE_HOST:$MODEL_PORT;
            proxy_set_header   Host               $host;
            proxy_set_header   X-Real-IP          $remote_addr;
            proxy_set_header   X-Forwarded-For    $proxy_add_x_forwarded_for;
        }
        location ~ ^/model/apispec_[0-9]+\.json$ {
            proxy_pass         http://$MODEL_SERVICE_HOST:$MODEL_PORT;
            proxy_set_header   Host               $host;
            proxy_set_header   X-Real-IP          $remote_addr;
            proxy_set_header   X-Forwarded-For    $proxy_add_x_forwarded_for;
        }

        # Model-service API endpoints
        # Strips off the /model prefix so /model/health -> /health on the container
        location /model/ {
            rewrite            ^/model/(.*)$ /$1 break;
            proxy_pass         http://$MODEL_SERVICE_HOST:$MODEL_PORT;
            proxy_set_header   Host               $host;
            proxy_set_header   X-Real-IP          $remote_addr;
            proxy_set_header   X-Forwarded-For    $proxy_add_x_forwarded_for;
        }

        # App-service Swagger UI & JSON
        location = /app/apidocs {
            proxy_pass         http://$APP_SERVICE_HOST:$APP_PORT;
            proxy_set_header   Host               $host;
            proxy_set_header   X-Real-IP          $remote_addr;
            proxy_set_header   X-Forwarded-For    $proxy_add_x_forwarded_for;
        }
        location ~ ^/app/flasgger_static/ {
            proxy_pass         http://$APP_SERVICE_HOST:$APP_PORT;
            proxy_set_header   Host               $host;
            proxy_set_header   X-Real-IP          $remote_addr;
            proxy_set_header   X-Forwarded-For    $proxy_add_x_forwarded_for;
        }
        location ~ ^/app/apispec_[0-9]+\.json$ {
            proxy_pass         http://$APP_SERVICE_HOST:$APP_PORT;
            proxy_set_header   Host               $host;
            proxy_set_header   X-Real-IP          $remote_addr;
            proxy_set_header   X-Forwarded-For    $proxy_add_x_forwarded_for;
        }

        # App-service API
        # Strips off /api so /api/predict -> /predict on the container
        location /api/ {
            rewrite            ^/api/(.*)$ /$1 break;
            proxy_pass         http://$APP_SERVICE_HOST:$APP_PORT;
            proxy_set_header   Host               $host;
            proxy_set_header   X-Real-IP          $remote_addr;
            proxy_set_header   X-Forwarded-For    $proxy_add_x_forwarded_for;
        }

        # Frontend SPA fallback
        location / {
            proxy_pass         http://$FRONTEND_SERVICE_HOST:$FRONTEND_PORT;
            proxy_set_header   Host               $host;
            proxy_set_header   X-Real-IP          $remote_addr;
            proxy_set_header   X-Forwarded-For    $proxy_add_x_forwarded_for;
        }
    }
}
