# japanese-dictionary

英和/和英の辞書を引くためのAtomパッケージです。[Weblio](http://ejje.weblio.jp/)か[ALC](http://www.alc.co.jp/)で単語を検索します。

![screen cast](https://raw.github.com/hokaccha/atom-japanese-dictionary/master/japanese-dictionary.gif)

## Install

```
$ apm install japanese-dictionary
```

## Commands

|name|keybind|description|
|----|-------|-----------|
|`japanese-dictionary:open-by-selection`|`ctrl-alt-x`|選択しているテキストで辞書サービスを開く|
|`japanese-dictionary:open-by-input`|`ctrl-alt-shift-X`|単語入力ダイアログを開く|

## Settings

|name|description|value|default|
|----|-----------|-----|-------|
|Service|検索サービス|weblio/alc|weblio|
