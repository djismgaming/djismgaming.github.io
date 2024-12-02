# mkdocs for github pages site

Visit me at [https://djismgaming.github.io](https://djismgaming.github.io)

## notes to self :D

- Microsoft Visual C++ 14.0 or greater is required. Get it with "Microsoft C++ Build Tools": https://visualstudio.microsoft.com/visual-cpp-build-tools/

Install the [GTK for Windows Runtime](https://github.com/tschoonj/GTK-for-Windows-Runtime-Environment-Installer/releases) to avoid `cairo` errors upon executing `mkdocs serve`

Execute on Git Bash

``` bash
python -m venv .venv
source .venv/Scripts/activate
python -m pip install --upgrade pip setuptools wheel
pip install -r requirements.txt
```

``` bash
mkdocs serve
```
