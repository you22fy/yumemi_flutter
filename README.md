# 株式会社ゆめみ Flutter エンジニアコードチェック課題

## 課題概要

[yumemi-inc/flutter-engineer-codecheck: This is a code check task for Flutter engineers employment in YUMEMI.](https://github.com/yumemi-inc/flutter-engineer-codecheck)

## 制作物詳細

### 概要

#### 実装内容

- お題である「GitHub リポジトリ検索アプリ」を Flutter で実装
- 検索ワードを入力し、github 上のリポジトリを検索し、検索結果をリスト表示
- リストアイテムをタップすると、リポジトリの詳細画面に遷移し、リポジトリの詳細情報を表示
- ダークモード対応
- 日本語・英語の多言語対応
- 画面回転に対応
- アプリアイコンの作成と設定に対応

#### 実装期間

2024/05/02 ~ 2024/05/08

### スクリーンショット・デモ動画

#### iOS

| テーマ | 検索画面                                                                                                                                                     | リポジトリ詳細                                                                                                                                               |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| ライト | ![Simulator Screenshot - iPhone 15 - 2024-05-08 at 04 34 25](https://github.com/you22fy/yumemi_flutter/assets/93398385/654d1f12-02fd-4905-b90e-ec2dc46d1343) | ![Simulator Screenshot - iPhone 15 - 2024-05-08 at 04 34 34](https://github.com/you22fy/yumemi_flutter/assets/93398385/0e872d55-c55a-4f5e-9771-4b35972300bf) |
| ダーク | ![Simulator Screenshot - iPhone 15 - 2024-05-08 at 04 34 28](https://github.com/you22fy/yumemi_flutter/assets/93398385/9e734c6a-fe34-4934-9c74-45c35736f564) | ![Simulator Screenshot - iPhone 15 - 2024-05-08 at 04 34 36](https://github.com/you22fy/yumemi_flutter/assets/93398385/d4aa2d1b-db5c-4914-8410-604a4a3011d9) |

#### Android

| テーマ | 検索画面                                                                                                                 | リポジトリ詳細                                                                                                           |
| ------ | ------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------ |
| ライト | ![Screenshot_1715110060](https://github.com/you22fy/yumemi_flutter/assets/93398385/88dd81c1-61a7-4a6b-92a3-986020371edc) | ![Screenshot_1715110036](https://github.com/you22fy/yumemi_flutter/assets/93398385/66105367-1335-4ff7-a274-fe65367ac851) |
| ダーク | ![Screenshot_1715110232](https://github.com/you22fy/yumemi_flutter/assets/93398385/af5c6446-734f-40ac-961b-30b730e14c10) | ![Screenshot_1715110235](https://github.com/you22fy/yumemi_flutter/assets/93398385/50a1bd9d-33c7-45d8-9155-b26e9a4e1e30) |

|

### 実行方法

当プロジェクトは iOS, android のみに対応しています。

1. 当リポジトリを clone

```
git clone https://github.com/you22fy/yumemi_flutter.git
```

2. プロジェクトディレクトリに移動

```
cd yumemi_flutter
```

3. fvm で指定のバージョンをインストール
   当プロジェクトでは flutter`3.19.5`を使用しています。fvm を使用しない場合は、バージョン`3.19.5`が動作するようにしてください。

```
fvm install
```

4. パッケージをインストール

```
fvm flutter pub get
```

5.  多言語対応のためのコード生成

```
fvm flutter gen-l10
```

6. アプリを起動

```
fvm flutter run
```

### 使用ツール

#### 開発環境

- macOS Sonoma 14.4.1
- Visual Studio Code 1.88.1
- Xcode Version 15.3 (15E204a)

#### 使用言語/フレームワーク

- Flutter 3.19.5
- Dart 3.3.3

#### パッケージ

使用したパッケージは以下の通りです。
| パッケージ名 | 用途 |
| --- | --- |
| flutter_riverpod | 状態管理 |
| flutter_hooks | 狭い範囲での状態管理 |
| hooks_riverpod | riverpod と hooks を併用するためのパッケージ |
| go_router | ルーティング |
| dio | HTTP 通信 |
| infinite_scroll_pagination | 無限スクロール |
| flutter_launcher_icons | アプリアイコンの設定 |
| github_language_colors | GitHub の言語カラーを取得 |
| intl | 多言語対応で使用 |
| shared_preferences | 選択言語の保存で使用 |
| flutter_localizations | 多言語対応で使用 |

#### その他ツール

- figma(ロゴ作成)
- FigJam ボード(作業の流れ整理)
- Git/GitHub(バージョン管理)
- GitHub Actions(静的解析, 自動ビルド)

#### AI ツール

- chatGPT (コーディングの質問・リファクタリング)
- CodeRabbit(PullRequest のレビュー)
- GitHub Copilot(コーディング補助)

### ディレクトリ構成

lib 配下のディレクトリ構成は以下の通りです。

| ディレクトリ名 | 用途                                                                           |
| -------------- | ------------------------------------------------------------------------------ |
| components     | UI コンポーネントを格納するディレクトリ                                        |
| l10n           | 多言語対応のためのディレクトリ                                                 |
| models         | データのモデルクラスを格納するディレクトリ                                     |
| pages          | page を格納するディレクトリ.1 つの page に対して 1 つのディレクトリを作成する. |
| providers      | アプリ全体で参照したい状態を提供する provider を格納                           |
| repositories   | API 通信を行うリポジトリクラスを格納するディレクトリ                           |
| utils          | アプリ全体で使用する class や関数を格納するディレクトリ                        |

### 今回できなかったこと

- test の実装
  - 今回は時間がなかったため、テストの実装ができませんでした。
- GitHub の活用
  - GitHub の issue・project などを利用はしましたが、効果的には活用できていないと感じています。
