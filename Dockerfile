FROM public.ecr.aws/nginx/nginx:1.19.6

EXPOSE 80

COPY index.html /usr/share/nginx/html
