# mkdocs for github pages site

Visit me at [https://djismgaming.github.io](https://djismgaming.github.io)

Install the [GTK for Windows Runtime](https://github.com/tschoonj/GTK-for-Windows-Runtime-Environment-Installer/releases) to avoid `cairo` errors upon executing `mkdocs serve`

Execute on Git Bash

``` bash
python -m venv .venv
source .venv/Scripts/activate
pip install -r requirements.txt
``` 

before 

``` bash
mkdocs serve
```