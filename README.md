# castle-search-api-environment

これは、[castle-search-api](https://github.com/takenoko-gohan/castle-search-api)の実行環境になります。

# 実行環境の構築方法

```sh
git clone https://github.com/takenoko-gohan/castle-search-api-environment.git
cd castle-search-api-environment
docker-compose up -d
# elasticsearch 起動後しばらくしてから実行してください
sh es/script/es_init.sh 
```
