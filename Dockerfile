# Use the official httpd (Apache HTTP Server) image as the base image
FROM httpd:2.4

# Copy your HTML files to the appropriate directory
COPY html/resume.html /usr/local/apache2/htdocs/
COPY html/index.html /usr/local/apache2/htdocs/

# Copy JavaScript and CSS files to their respective directories
COPY js/visitorcount.js /usr/local/apache2/htdocs/js/
COPY css/resume-style.css /usr/local/apache2/htdocs/

# Copy images to the images directory
COPY img/* /usr/local/apache2/htdocs/img/

# Expose port 443 for the Apache server (HTTPS)
EXPOSE 443

# Start Apache in the foreground
CMD ["httpd-foreground"]
