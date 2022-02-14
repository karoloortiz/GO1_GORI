AFTER CLONING REPO:
cloning submodules:
git submodule init 
git submodule update

# CREATING NEW REPO

SUBMODULE
git submodule add https://github.com/sandrocarrara/GO-STANDARD.git src/GO-STANDARD

git submodule add https://github.com/karoloortiz/Delphi_Utils_Library.git src/KLib/Delphi_Utils_Library
git submodule add https://github.com/karoloortiz/Delphi_Async_Library.git src/KLib/Delphi_Async_Library
git submodule add https://github.com/karoloortiz/Delphi_FormUtils_Library.git src/KLib/Delphi_FormUtils_Library
git submodule add https://github.com/karoloortiz/Delphi_MySQL_Library.git src/KLib/Delphi_MySQL_Library
git submodule add https://github.com/karoloortiz/Delphi_SQLServer_Library.git src/KLib/Delphi_SQLServer_Library
git submodule add https://github.com/karoloortiz/GO_Library.git src/KLib/GO_Library

LFS
git lfs track analisi/kar.PLATINUMDATA.CENTRO_BATTERIE.analisi.2021.09.14.all1.odt
git lfs track src/assets.res
git lfs track bmp/go.jpg