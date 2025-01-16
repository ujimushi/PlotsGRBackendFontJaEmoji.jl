# PlotsGRBackendFontJaEmoji.jl
Plots.jlのGRバックエンドで日本語と絵文字を手軽に使える環境を提供します。

Pythonにおける[matplotlib-fonja](https://github.com/ciffelia/matplotlib-fontja)に相当するもの
といえば分かりやすいかもしれません。

## インストール方法

githubから直接インストールして下さい。

```julia
using Pkg
Pkg.add(url="https://github.com/ujimushi/PlotsGRBackendFontJaEmoji.jl")
```

## 利用例

`using PlotsGRBackendFontJaEmoji`だけで日本語と絵文字が利用できます。
パッケージに添付している[Cica Font](https://github.com/miiton/Cica)を利用しています。

```julia
using Plots
using PlotsGRBackendFontJaEmoji

gr()

plot(sin; title="日本語🐱")
```

## その他の機能

`Plots.jl`の`GR`バックエンドで任意のフォントを利用可能とする
`plots_gr_register_user_font()`関数を用意しています。

    plots_gr_register_user_font(fontname, fontpath) 

* `fontname`: 登録するフォント名を指定します。
* `fontpath`: OSにインストールされている`フォントファイル名`もしくは
  フォントファイルの`フルパス`を指定します。

例えばWindowsの場合、次のようにすることでMSゴシックフォントを利用可能です。

```julia
using Plots
using PlotsGRBackendFontJaEmoji

gr()

plots_gr_register_user_font("ms gothic", "msgothic.ttc")
default(fontfamily="ms gothic")
plot(sin; title="日本語🐱")
```

## Plots.jlのデフォルトのフォント設定に戻す方法

引数無しで`default()`関数を呼びます。
