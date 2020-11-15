SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR
curl -XDELETE localhost:9200/castle?pretty=true
curl -XPUT http://localhost:9200/castle?pretty -H 'Content-Type: application/json' -d @../json/index_settings.json 
curl -XPUT http://localhost:9200/castle/_mapping?pretty -H 'Content-Type: application/json' -d @../json/index_mappings.json                                         
curl -XPOST http://localhost:9200/castle/_bulk?pretty -H 'Content-Type: application/json' --data-binary @../json/data.json