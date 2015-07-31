## 概要
本プロジェクトは、Rails学習用に作成中のDropboxのコピーサイトです。

## 仕様
* ユーザー管理機能
    * ユーザー登録
        * メール認証
    * ユーザー情報更新・削除
    * ログイン、ログアウト機能
* ファイル管理機能
    * ファイル一覧表示
        * フォルダ選択
        * ソート（ファイル名、種類、更新日時）
        * ファイル名検索
    * ローカルファイルのアップロード
    * ファイルダウンロード
    * ファイル名変更
    * ファイル移動・コピー・削除
    * フォルダ作成
    * イベント記録（すべてのファイル変更の記録）
    * イベント一覧表示
* ファイル共有機能
    * 他ユーザーとの共有設定・解除
    * 共有リンク生成
        * リンクURLを共有相手へメール送信

## 時間配分

* 環境設定 (5m)
* ファイル管理機能の実装 (5h)
    * ファイル一覧表示
        * フォルダ選択
    * ローカルファイルのアップロード
    * ファイルダウンロード
    * ファイル名変更
    * フォルダ作成
* Herokuの設定(1H)
    * コンテンツのuploadに時間がかかる。
