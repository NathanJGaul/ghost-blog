# ghost-blog

## Setting Up

The directions below are using [dokku](https://github.com/dokku/dokku), a self hosted PaaS, to setup and host the ghost blog.

### 1. Create a new dokku app

```
# dokku host
dokku apps:create blog
```

### 2. Create a new dokku MySQL container

```
# dokku host
dokku mysql:create blog-db
```

### 3. Link the database and app containers

```
# dokku host
dokku mysql:link blog-db blog
```

Make sure to take note of the `DATABASE_URL` returned by this command. It should be in form `mysql://<user>:<password>@<host>:<port>/<database>`.

### 4. Configure the ghost environmental variables

Make sure to replace all `<...>` with the correct information.

```
# dokku host
dokku config:set --no-restart blog \
> url=https://blog.mydomain.com \
> database__client=mysql \
> database__connection__host=<host> \
> database__connection__port=<port> \
> database__connection__user=<user> \
> database__connection__password=<password> \
> database__connection__database=<database> \
> mail__transport=SMTP \
> mail__options__service=Mailgun \
> mail__options__auth__user=<mailgun-user> \
> mail__options__auth__pass=<mailgun-password>
```

### 5. Add port 80 for http to the dokku proxy configuration

We'll also remove the default port configuration.

```
# dokku host
dokku proxy:ports-add blog http:80:2368
dokku proxy:ports-remove blog http:2368:2368
```

### 6. Deploy this repository

```
# remote machine
git push dokku master
```

### 7. Add SSL with letsencrypt

```
# dokku host
dokku letsencrypt blog
```

### 8. Mount persistent storage

Make sure to restart the app.

```
# dokku host
dokku storage:mount blog /var/lib/dokku/data/storage/blog:/var/lib/ghost/content
dokku ps:restart blog
```
