Docker local-php-security-checker
---------------------------------

Docker image based on [local-php-security-checker](https://github.com/fabpot/local-php-security-checker)

You can use it to scan your composer dependencies. Useful to make a CI fail.

Parameters and return codes are documented on the tool's Readme. You can run it with `-help` to display some help.

# Usage

## Locally
```shell
docker run -v /path/to/your/project:/project:ro viviengaetan69/docker-local-php-security-checker:0.1.5 -path=/project
```

## Gitlab CI

> [!NOTE]
> In this example, application is in the `app` directory, adapt it to your own usage

````yaml
security:advisories:
  image: viviengaetan69/docker-local-php-security-checker:0.1.5
  stage: sast
  script:
  - cd app
  - local-php-security-checker --format=junit src > $CI_PROJECT_DIR/report-security-checker.xml
  artifacts:
    reports:
      junit:
      - "$CI_PROJECT_DIR/report-security-checker.xml"
  rules:
  - exists:
    - app/composer.lock
````
