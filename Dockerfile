FROM nginx:latest
ENV PORT=8080
COPY nginx.conf /etc/nginx/templates/default.conf.template
COPY cert/oddbox.crt /etc/ssl/oddbox.crt
COPY cert/oddbox.key /etc/ssl/oddbox.key
COPY --from=builder /app/build /var/www/dist
