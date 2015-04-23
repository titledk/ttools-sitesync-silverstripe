# How to debug issues with site sync

## Database import/export issues

If the database doesn't get exported correctly, you can try the following:

	php ttools/thirdparty/sspak/src/sspak-sniffer.php /path/to/git-repos/current/myrepo/public


## Errors

### Segmentation fault: 11

Run `php --version` from the command line and check if your command line
php version matches the apache php version - if not, correct that

This happened to me after having added the homebrew path a new `.bash_profile` file.
I had been setting MAMP's php path in my `.profile` file, but that setting seemed
to have overwritten it with the php version that was installed with homebrew.