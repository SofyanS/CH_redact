# Create a GCS bucket
gsutil mb -l us-central1 gs://$DEVSHELL_PROJECT_ID-upload/

# Create a Cloud Storage Bucket for Staging Contents
gsutil mb -l us-central1 gs://$DEVSHELL_PROJECT_ID-staging/
touch tmp.txt
gsutil cp tmp.txt gs://$DEVSHELL_PROJECT_ID-staging/DFaudio/tmp.txt

# Create Cloud Pub/Sub Topic
gcloud pubsub topics create payload

# Create BQ Dataset
bq mk saf
bq mk --table $DEVSHELL_PROJECT_ID:saf.transcripts bigquery/schema.json

# Create cloud function to process audio filess when uploaded to the bucket
yes | gcloud functions deploy safLongRunJobFunc --runtime nodejs8 --trigger-resource gs://$DEVSHELL_PROJECT_ID-upload --trigger-event google.storage.object.finalize --source=saf-longrun-job-func

# Deploy a Cloud Dataflow Pipeline 
# --save_main_session True --requirements_file requirements.txt
cd saf-longrun-job-dataflow
#python -m virtualenv env -p python3
#source env/bin/activate
#sudo pip3 install -r requirements.txt
python saflongrunjobdataflow.py --output_bigquery $DEVSHELL_PROJECT_ID:saf.transcripts --input_topic projects/$DEVSHELL_PROJECT_ID/topics/payload --region us-central1 --project $DEVSHELL_PROJECT_ID --temp_location gs://$DEVSHELL_PROJECT_ID-staging/ --staging_location gs://$DEVSHELL_PROJECT_ID-staging/ --save_main_session True --runner DataflowRunner

# Upload Sample Audio Files for Processing
gsutil -h x-goog-meta-agentid:1234567 -h x-goog-meta-stereo:true -h x-goog-meta-agentchannel:1 -h x-goog-meta-pubsubtopicname:payload -h x-goog-meta-year:2019 -h x-goog-meta-month:11 -h x-goog-meta-day:06 -h x-goog-meta-starttime:1116 cp sample-audio/* gs://$DEVSHELL_PROJECT_ID-upload/

# Run a DLP Job https://cloud.google.com/bigquery/docs/scan-with-dlp


