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

# Install nano during Docker image build
RUN apt-get update && \
    apt-get install -y nano

# Uncomment socache_shmcb_module
RUN sed -i 's~#LoadModule socache_shmcb_module~LoadModule socache_shmcb_module~' /usr/local/apache2/conf/httpd.conf

# Uncomment socache_shmcb_module
RUN sed -i 's~#LoadModule ssl_module~LoadModule ssl_module~' /usr/local/apache2/conf/httpd.conf

# Uncomment httpd-ssl.conf
#RUN sed -i 's~#Include conf/extra/httpd-ssl.conf~Include conf/extra/httpd-ssl.conf~' /usr/local/apache2/conf/httpd.conf

# Replace Listen 80 with Listen 8080
RUN sed -i 's~Listen 80~Listen 8080~' /usr/local/apache2/conf/httpd.conf

# Add VirtualHost configuration
RUN echo "<VirtualHost *:8080>" >> /usr/local/apache2/conf/httpd.conf
RUN echo "    DocumentRoot \"/usr/local/apache2/htdocs\"" >> /usr/local/apache2/conf/httpd.conf
RUN echo "    ServerName grahambaggett.net" >> /usr/local/apache2/conf/httpd.conf
RUN echo "" >> /usr/local/apache2/conf/httpd.conf
RUN echo "    <Directory \"/usr/local/apache2/htdocs\">" >> /usr/local/apache2/conf/httpd.conf
RUN echo "        Options Indexes FollowSymLinks" >> /usr/local/apache2/conf/httpd.conf
RUN echo "        AllowOverride None" >> /usr/local/apache2/conf/httpd.conf
RUN echo "        Require all granted" >> /usr/local/apache2/conf/httpd.conf
RUN echo "    </Directory>" >> /usr/local/apache2/conf/httpd.conf
RUN echo "</VirtualHost>" >> /usr/local/apache2/conf/httpd.conf

# Start Apache in the foreground
CMD ["httpd-foreground"]
