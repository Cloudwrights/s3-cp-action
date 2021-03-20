# GitHub Action to `aws s3 cp` a file to an S3 Bucket 🔄 

This simple action uses the [vanilla AWS CLI](https://docs.aws.amazon.com/cli/index.html) to copy a file to a remote S3 bucket. The only difference from the original repo this was forked from is the existence check - this job overwrites the key every time.



## Usage

### `workflow.yml` Example

Place in a `.yml` file such as this one in your `.github/workflows` folder. [Refer to the documentation on workflow YAML syntax here.](https://help.github.com/en/articles/workflow-syntax-for-github-actions)

```
# This action will upload artifact to an S3 folder.
name: Build & Deploy to S3

on:
  push:
    branches:
      - release/*

jobs:
  delivery:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Deploy
      uses: airuleguy/s3-cp-action@master
      env:
        FILE: artifact.jar
        SOURCE_PATH: /path/to/jar/
        DESTINATION_KEY: /s3/key/
        AWS_S3_BUCKET: ${{ secrets.AWS_S3_BUCKET }}
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        AWS_REGION: 'us-east-1'
```


### Required Environment Variables

| Key | Value | Type | Required |
| ------------- | ------------- | ------------- | ------------- |
| `FILE` | The local file you wish to upload to S3. For example, `./myfile.txt`. | `env` | **Yes** |
| `SOURCE_PATH` | Path where to find `FILE`, can be absolute or relative, must end in `/`. `/path/to/myfile/`. | `env` | **Yes** |
| `DESTINATION_KEY` | Key under which to store `FILE` in S3. This will be concatenated to `AWS_S3_BUCKET` to create the full ARN. `/destination/key/`. | `env` | **Yes** |
| `AWS_REGION` | The region where you created your bucket in. For example, `eu-central-1`. [Full list of regions here.](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-available-regions) | `env` | **Yes** |


### Required Secret Variables

The following variables should be added as "secrets" in the action's configuration.

| Key | Value | Type | Required |
| ------------- | ------------- | ------------- | ------------- |
| `AWS_S3_BUCKET` | The name of the bucket you're syncing to. For example, `artifact/jar/`. | `secret` | **Yes** |
| `AWS_ACCESS_KEY_ID` | Your AWS Access Key. [More info here.](https://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html) | `secret` | **Yes** |
| `AWS_SECRET_ACCESS_KEY` | Your AWS Secret Access Key. [More info here.](https://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html) | `secret` | **Yes** |


## License

This project is distributed under the [MIT license](LICENSE.md).
