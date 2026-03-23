PHP Code sniffer GitHub action
-
This action runs phpcs with YNA ruleset with GitHub action

Usage
-

Add this code to `.github/workflows/main.yml` file.

    name: PHPCS check
      on: push/pull_request

      jobs:
        phpcs:
          name: PHPCS
          runs-on: ubuntu-latest
          steps:
            - uses: actions/checkout@v2
            - name: PHPCS check
              uses: yournextagency/github-actions-php@master 

By default, php_cs checks the code in `modules` directory.
You can pass a set of your own directories using `phpcs_paths` input

    - name: PHPCS check
      uses: yournextagency/github-actions-php@master
      with:
        phpcs_paths: './modules ./plugins ./any_other_dir'

How to use CodeSniffer (phpcs) locally and/or with PhpStorm
-
### Download the latest version of phpcs:
`curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar`  
or using wget
`wget https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar`
Check phar: `php phpcs.phar -h`  
or using composer
`composer global require "squizlabs/php_codesniffer=*"`


For debian-like systems, make symlink of binary to global scope (sudo):  
`ln -s \path\to\downloaded\phar \usr\bin\phpcs`  
`chmod +x \usr\bin\phpcs`

### Set up YNA coding standard

- Download `YNA` directory from this repo
- Set new standard for phpcs: `phpcs --config-set installed_paths path/github-actions-php/YNA`
- Check that `YNA` string exists in the output of `phpcs -i`

### Use CodeSniffer in CLI

To check single class:  
`phpcs --standard=YNA /path/to/php/class.php`

You can set YNA standard as default:  
`phpcs --config-set default_standard YNA`
then
`phpcs /path/to/php/class.php`

For more usage cases check [official documentation](https://github.com/PHPCSStandards/PHP_CodeSniffer/wiki "Title")

### Use CodeSniffer in PHPStorm
- `Preferences -> Languages & Frameworks -> PHP -> Quality tools -> Code Sniffer`
  In Configuration Local intup click `...` button.  
  Set path to phpcs binary and click `Validate`. The current version on phpcs must be shown  
  Set 15 - 30 in `Tool process timeout` input.  
  `Apply -> OK.`

- `Preferences -> Editor -> Inspections -> PHP -> Quality tools -> PHP Code Sniffer validation`  
  Select `YNA` in `Coding Standard` selectbox.

- `File -> Invalidate Caches / Restart`
