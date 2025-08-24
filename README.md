# terraform-practice

[実践Terraform　AWSにおけるシステム設計とベストプラクティス](https://item.rakuten.co.jp/rakutenkobo-ebooks/1130e46b09d13b9d9b760b55dbe70c98/) をやってみた。

## 引っかかったところ

### principals ブロックの指定

正しくは `type = "Service"` だったが、`type = "service"` と記述してしまい、`terraform apply` に失敗してしまった。  
エラーのメッセージが下記のように表示されたため、原因の特定に時間がかかった。。。

```bash
│ Error: creating IAM Role (exampleRole): operation error IAM: CreateRole, https response error StatusCode: 400, RequestID: f42e787b-0c5f-4c24-abb7-6a11711258e5, MalformedPolicyDocument: Syntax error at position (1,83)
│ 
│   with aws_iam_role.example_role,
│   on main.tf line 25, in resource "aws_iam_role" "example_role":
│   25: resource "aws_iam_role" "example_role" {

```

ちなみにIAMポリシーはマネージドのものも利用できるようだ。

[【AWS】TerraformでAWS管理ポリシーを使用する](https://qiita.com/nossy/items/ac976f7382bd14a6d099)

### バケットの設定で非推奨項目があった

[『実践Terraform』でバケット定義の書き方が非推奨と警告されてしまう](https://qiita.com/Kazuyaa/items/612e678cccf0b23a2d5e)で紹介されていたが、S3バケットの記述方法がバージョンアップによって変わったようだ。

また書籍だとACLを利用していたので、バケットポリシーを利用するよう変更した。
[S3のACLの非推奨になったのでBucketPolicyへ移行してみた](https://dev.classmethod.jp/articles/s3-acl-bucketpolicy/)

### *.tf 内で自身のAWSアカウントIDにアクセスする

[*.tf 内で AWS アカウント ID を自動参照(取得)する aws_caller_identity Data Source AWS Terraform](https://qiita.com/gongo/items/a2b83d7402b97ef43574) を参照。

