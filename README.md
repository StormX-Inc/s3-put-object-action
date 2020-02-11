# GitHub Action to put an object to a remote S3 bucket 🔄 

This simple action uses the [vanilla AWS CLI](https://docs.aws.amazon.com/cli/index.html) to put an object (either from your repository or generated during your workflow) to a remote S3 bucket.

## Usage

### `workflow.yml` Example

Place in a `.yml` file such as this one in your `.github/workflows` folder. [Refer to the documentation on workflow YAML syntax here.](https://help.github.com/en/articles/workflow-syntax-for-github-actions)

```
name: Sync Bucket
on: push

jobs:
  deploy:
    runs-on: ubuntu-latest
    
  steps:
   - uses: actions/checkout@master
   
   - name: Upload file-name.zip to S3 bucket
     uses: StormX-Inc/s3-put-object-action@master
     env:
       FILE: ./file-name.zip
       KEY: project-name/file-name.zip
```


### Required Environment Variables

| Key | Value | Type | Required |
| ------------- | ------------- | ------------- | ------------- |
| `AWS_S3_BUCKET` | The name of the bucket you're copying to. For example. | `env` | **Yes** 
| `FILE` | The local file you wish to upload to S3. For example, `./file-name.zip`. | `env` | **Yes** |
| `KEY` | The key param for the S3 put-object command. For example, `project-name/file-name.zip`. | `env` | **Yes** |


### Required Secret Variables

The following variables should be added as "secrets" in the action's configuration.

| Key | Value | Type | Required |
| ------------- | ------------- | ------------- | ------------- |
| `AWS_ACCESS_KEY_ID` | Your AWS Access Key. [More info here.](https://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html) | `secret` | **Yes** |
| `AWS_SECRET_ACCESS_KEY` | Your AWS Secret Access Key. [More info here.](https://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html) | `secret` | **Yes** |
