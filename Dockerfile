FROM public.ecr.aws/nginx/nginx:1.19.6

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./default.conf /etc/nginx/conf.d/default.conf

## add permissions
RUN chown -R nginx:nginx /var/cache/nginx && \
        chown -R nginx:nginx /var/log/nginx && \
        chown -R nginx:nginx /etc/nginx/conf.d
RUN touch /var/run/nginx.pid && \
         chown -R nginx:nginx /var/run/nginx.pid

## switch to non-root user
USER nginx

## add index.html
COPY index.html /usr/share/nginx/html

EXPOSE 8080

## run server
CMD nginx -g 'daemon off;'
