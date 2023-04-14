##  アプリケーション名
  「studio schedule」

## アプリケーション概要
  練習スタジオの利用抽選サイトです。  
  利用希望日を選択し、応募すると、締め切りの後に、利用可能者が各時間帯最大１組抽選されます。  
  DM機能を実装しているため、外れた時間帯や急用の際に、当選者に交渉することができます。  
  ![image](https://user-images.githubusercontent.com/106065354/227141382-b3d69eac-03d9-4b80-9d4d-ea0b0d42635c.png)

## URL
  http://67.202.20.85/


## 利用方法
  利用者：ユーザー登録をして、「スタジオ抽選」にて、利用希望時間を応募します。締め切り後「抽選結果」から結果を確認します。「抽選結果」ではユーザー名をクリックすることでプロフィールに遷移し、DMで交渉を行えます。  

  管理者：「抽選結果」にて、抽選結果の公開非公開を設定できます。締め切り時は公開、募集時には非公開に設定後、前回結果をリセットします。

## 目指した課題解決
  大学のサークルにて、毎週末、希望時間を聞き、手動でスタジオのスケジュール管理を行なっており、時間を要していました。そこで抽選のシステムを作ることで、特定の人間に負担が偏らなくなることを目指しました。

## 使用技術
  ・HTML  
  ・CSS  
  ・JavaScript  
  ・JQuery  
  ・Ruby 2.7.6  
  ・Ruby on Rails 6.1.7  
  ・MySQL 8.0.32  
  ・Nginx  
  ・Unicorn  
  ・AWS(VPC,EC2)  
  ・RSpec  

## ER図
 ![image](https://user-images.githubusercontent.com/106065354/227135660-0f676be0-c1b3-47bc-95e3-f91b15ce34ed.png)


