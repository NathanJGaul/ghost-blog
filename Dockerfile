FROM ghost:2

EXPOSE $PORT

ENV url=https://blog.nathanjgaul.com

ENV server__host=0.0.0.0
ENV server__port=$PORT

ENV database__client=mysql
ENV database__connection__host=dokku-mysql-blog-db
ENV database__connection__port=3306
ENV database__connection__user=mysql
ENV database__connection__password=dd3a9823375d4793
ENV database__connection__database=blog-db

ENV mail__transport=SMTP
ENV mail__options__service=Mailgun
ENV mail__options__auth__user=postmaster@mg.nathanjgaul.com
ENV mail__options__auth__pass=2f66de74f490e77578a97a7e1e3d03cf-c8c889c9-13efb38d