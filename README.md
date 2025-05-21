*rdiff-backup-rdiffweb*

Original Source: https://github.com/waazaa-fr/rdiff-backup-rdiffweb

Added an optional include-list file (see https://rdiff-backup.net/examples.html#file_selection_with_includeexclude_options for syntax)

=======================================================================

# Docker run #

```bash
docker run -it --rm --name rdiffweb-test \
    -v /path/to/app:/app \
    -v /path/to/backups:/backups \
    -v /path/to/source:/source \
    -p 8080:8080 \
    -e CRON_PATTERN="0 */12 * * *" \
    -e EMAIL_HOST="mail.example.com:587" \
    -e EMAIL_SENDER="sender@example.com" \
    -e EMAIL_USERNAME="sender@example.com" \
    -e EMAIL_PASSWORD="P4sswOrD" \
    waazaafr/rdiff-backup-rdiffweb:latest
```



# Docker compose #

```yaml
services:
  rdiff-backup-rdiffweb:
    image: waazaafr/rdiff-backup-rdiffweb:latest
    container_name: rdiff-backup-rdiffweb
    environment:
      - TZ=Europe/Paris
      - CRON_PATTERN=0 */12 * * *
      - EMAIL_HOST=mail.example.com:587
      - EMAIL_SENDER=sender@example.com
      - EMAIL_USERNAME=sender@example.com
      - EMAIL_PASSWORD=P4sswOrD
    volumes:
      - /path/to/app:/app
      - /path/to/backups:/backups
      - /path/to/source:/source
    ports:
      - 8080:8080
    restart: unless-stopped
```

=======================================================================

Feel free to join me on https://discord.gg/p9xkjEw8ts

If you like this, consider buing me a coffee: https://buymeacoffee.com/waazaa

If you need an UnRAID license follow this link: https://unraid.net/pricing?via=4c3f80
